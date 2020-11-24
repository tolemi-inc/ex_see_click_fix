defmodule ExSeeClickFix.Request do
  require Logger

  @fuse_name __MODULE__
  @fuse_options [
    # Tolerate 20 failures for every 60 second time window.
    fuse_strategy: {:standard, 20, 60_000},
    # Reset the fuse 5 seconds after it is blown.
    fuse_refresh: 5_000,
    # Limit to 20 calls per 60 seconds
    rate_limit: {20, 60_000}
  ]

  @retry_opts %ExternalService.RetryOptions{
    # Use linear backoff. Exponential backoff is also available.
    backoff: {:linear, 1000, 1},
    # Stop retrying after 60 seconds.
    expiry: 60_000
  }
  def get(client, resource, options) do
    ExternalService.call(@fuse_name, @retry_opts, fn -> try_get(client, resource, options) end)
  end

  defp try_get(client, resource, options) do
    Tesla.get(client, resource, options)
    |> case do
      {:error, :timeout} ->
        {:retry, :timeout}

      {:ok, %{status: 429, headers: headers}} ->
        seconds = List.keyfind(headers, "retry-after", 0, "10") |> String.to_integer()
        Logger.warn("too many requests - waiting #{seconds} seconds")
        Process.sleep(seconds * 1000)
        {:retry, :too_many_requests}

      result ->
        result
    end
  end

  def start(options \\ []) do
    options = Keyword.merge(options, @fuse_options)
    ExternalService.start(@fuse_name, options)
  end
end
