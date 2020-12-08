defmodule ExSeeClickFix.RequestType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  embedded_schema do
    field(:organization, :string)
    field(:related_issues_url, :string)
    field(:title, :string)
    field(:url, :string)
  end

  def changeset(%__MODULE__{} = issue, params) do
    issue
    |> cast(params, [
      :id,
      :organization,
      :related_issues_url,
      :title,
      :url
    ])
  end
end
