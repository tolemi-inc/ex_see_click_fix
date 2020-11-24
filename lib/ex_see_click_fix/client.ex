defmodule ExSeeClickFix.Client do
  @base_url "https://seeclickfix.com/api/v2"

  def new(place) do
    middleware = [
      {Tesla.Middleware.Timeout, timeout: 15_000},
      {Tesla.Middleware.BaseUrl, @base_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Query, [place_url: place]}
    ]

    Tesla.client(middleware)
  end
end
