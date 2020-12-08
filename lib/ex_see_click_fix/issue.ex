defmodule ExSeeClickFix.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  embedded_schema do
    field(:status, :string)
    field(:summary, :string)
    field(:description, :string)
    field(:rating, :integer)
    field(:lat, :float)
    field(:lng, :float)
    field(:address, :string)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:acknowledged_at, :utc_datetime)
    field(:closed_at, :utc_datetime)
    # field :reporter
    embeds_one(:request_type, ExSeeClickFix.RequestType, on_replace: :delete)
    field(:shortened_url, :string)
    field(:url, :string)
    field(:comment_url, :string)
    field(:flag_url, :string)
    field(:html_url, :string)
    # field :media
  end

  def build(params) do
    %__MODULE__{}
    |> changeset(params)
    |> apply_action(:update)
  end

  def build_list(params) do
    params
    |> Enum.reduce([], fn raw_issue, issues ->
      case ExSeeClickFix.Issue.build(raw_issue) do
        {:ok, issue} ->
          [issue | issues]

        {:error, error} ->
          raise(error)
          issues
      end
    end)
  end

  def changeset(%__MODULE__{} = issue, params) do
    issue
    |> cast(params, [
      :id,
      :status,
      :summary,
      :description,
      :rating,
      :lat,
      :lng,
      :address,
      :created_at,
      :updated_at,
      :acknowledged_at,
      :closed_at,
      :shortened_url,
      :url,
      :comment_url,
      :flag_url,
      :html_url
    ])
    |> cast_embed(:request_type, with: &ExSeeClickFix.RequestType.changeset/2)
  end
end
