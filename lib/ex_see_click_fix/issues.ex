defmodule ExSeeClickFix.Issues do
  @resource "issues"

  def list(client, options \\ []) do
    with {:ok, %{body: body}} <- request(client, options) do
      Map.get(body, @resource)
      |> ExSeeClickFix.Issue.build_list()
    end
  end

  def request(client, options \\ []) do
    default_options = [per_page: 100, sort: "update_at", sort_direction: "DESC"]
    query = Keyword.merge(default_options, options)

    Tesla.get(client, @resource, query: query)
  end
end
