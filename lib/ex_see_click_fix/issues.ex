defmodule ExSeeClickFix.Issues do
  require Logger

  @resource "issues"

  def stream_list(client, options) do
    Stream.resource(
      fn ->
        %{pagination: nil, options: options}
      end,
      fn %{options: options, pagination: pagination} = meta ->
        case request_page(client, pagination, options) do
          {:ok, :eof} ->
            {:halt, meta}

          {:ok, %{status: 200} = response} ->
            issues = get_issues(response)
            pagination = get_pagination(response)

            Logger.info(
              "pulled #{ExSeeClickFix.Pagination.progress(pagination)} / #{
                ExSeeClickFix.Pagination.entries(pagination)
              }"
            )

            {issues, %{pagination: pagination, options: options}}

          {:ok, response} ->
            raise "Something went south: #{inspect(response)}"
        end
      end,
      fn _ -> :ok end
    )
  end

  defp request_page(client, nil, options) do
    request(client, options)
  end

  defp request_page(client, pagination, options) do
    if ExSeeClickFix.Pagination.has_next_page?(pagination) do
      next_options = get_next_options(pagination, options)
      request(client, next_options)
    else
      {:ok, :eof}
    end
  end

  defp get_next_options(nil, options), do: options

  defp get_next_options(pagination, options) do
    next_page = ExSeeClickFix.Pagination.next_page(pagination)

    options
    |> Keyword.merge(page: next_page)
  end

  def list(client, options \\ []) do
    with {:ok, response} <- request(client, options) do
      get_issues(response)
    end
  end

  defp get_issues(%{body: body}) do
    Map.get(body, @resource)
    |> ExSeeClickFix.Issue.build_list()
  end

  defp get_pagination(%{body: body}) do
    result =
      get_in(body, ["metadata", "pagination"])
      |> ExSeeClickFix.Pagination.build()

    case result do
      {:ok, pagination} ->
        pagination

      {:error, error} ->
        Logger.error(inspect(error))
        raise "unexpected pagination"
    end
  end

  def request(client, options \\ []) do
    default_options = [per_page: 100, sort: "update_at", sort_direction: "DESC"]
    query = Keyword.merge(default_options, options)

    ExSeeClickFix.Request.get(client, @resource, query: query)
  end
end
