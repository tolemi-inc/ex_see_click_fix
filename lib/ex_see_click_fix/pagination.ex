defmodule ExSeeClickFix.Pagination do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:entries, :integer)
    field(:next_page, :integer)
    field(:page, :integer)
    field(:per_page, :integer)
    field(:pages, :integer)
  end

  def build(params) do
    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:update)
  end

  def changeset(%__MODULE__{} = pagination, params) do
    pagination
    |> cast(params, [:entries, :next_page, :page, :pages, :per_page])
  end

  def entries(%{entries: entries}), do: entries
  def progress(%{page: page, per_page: per_page}), do: page * per_page

  def next_page(%{next_page: next_page}), do: next_page
  def has_next_page?(%{next_page: nil}), do: false
  def has_next_page?(_), do: true
end
