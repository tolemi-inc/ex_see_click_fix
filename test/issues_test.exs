defmodule ExSeeClickFix.IssuesTest do
  use ExUnit.Case
  doctest ExSeeClickFix

  # We need to mock globally, because we use ExternalService which makes
  # requests in a separate process.
  setup_all do
    Tesla.Mock.mock_global(fn
      %{
        method: :get,
        url: "https://seeclickfix.com/api/v2/issues",
        query: [
          sort: "update_at",
          sort_direction: "DESC",
          per_page: 1,
          place_url: "albany-county-single-page"
        ]
      } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "errors" => %{},
            "issues" => [
              %{
                "acknowledged_at" => nil,
                "address" => "147-149 Prichard Street Fitchburg, MA, 01420, USA",
                "closed_at" => nil,
                "comment_url" => "https://seeclickfix.com/api/v2/issues/8957626/comments",
                "created_at" => "2020-11-23T12:56:41-05:00",
                "description" => "missed Friday",
                "flag_url" => "https://seeclickfix.com/api/v2/issues/8957626/flag",
                "html_url" => "https://seeclickfix.com/issues/8957626",
                "id" => 8_957_626,
                "lat" => 42.5857019855574,
                "lng" => -71.8010439778683,
                "media" => %{
                  "image_full" => nil,
                  "image_square_100x100" => nil,
                  "representative_image_url" =>
                    "https://seeclickfix.com/assets/categories/trash-253f6f37c76ecf513079ab225a5a2acb301dc27c869c749bc6c592b779207bd5.png",
                  "video_url" => nil
                },
                "point" => %{
                  "coordinates" => [-71.8010439778683, 42.58570198555742],
                  "type" => "Point"
                },
                "private_visibility" => false,
                "rating" => 1,
                "reopened_at" => nil,
                "reporter" => %{
                  "avatar" => %{
                    "full" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png",
                    "square_100x100" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png"
                  },
                  "civic_points" => 0,
                  "html_url" => "https://seeclickfix.com/users/1287439",
                  "id" => 1_287_439,
                  "name" => "City of Fitchburg, MA Neighbor",
                  "role" => "Registered User",
                  "witty_title" => ""
                },
                "request_type" => %{
                  "id" => 7048,
                  "organization" => "Fitchburg, MA",
                  "related_issues_url" =>
                    "https://seeclickfix.com/api/v2/issues?lat=42.5857019855574&lng=-71.8010439778683&request_types=7048&sort=distance",
                  "title" => "Missed Trash, Recycling or Yard Waste Pickup",
                  "url" => "https://seeclickfix.com/api/v2/request_types/7048"
                },
                "shortened_url" => nil,
                "status" => "Open",
                "summary" => "Missed Trash, Recycling or Yard Waste Pickup",
                "transitions" => %{
                  "close_url" => "https://seeclickfix.com/api/v2/issues/8957626/close"
                },
                "updated_at" => "2020-11-23T12:56:42-05:00",
                "url" => "https://seeclickfix.com/api/v2/issues/8957626"
              }
            ],
            "metadata" => %{
              "pagination" => %{
                "entries" => 2,
                "next_page" => 2,
                "next_page_url" =>
                  "https://seeclickfix.com/api/v2/issues?page=2&per_page=1&place=albany-county&sort=update_at&sort_direction=DESC",
                "page" => 1,
                "pages" => 2,
                "per_page" => 1,
                "previous_page" => nil,
                "previous_page_url" => nil
              }
            }
          }
        }

      %{
        method: :get,
        url: "https://seeclickfix.com/api/v2/issues",
        query: [
          sort: "update_at",
          sort_direction: "DESC",
          per_page: 1,
          place_url: "albany-county-two-pages"
        ]
      } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "errors" => %{},
            "issues" => [
              %{
                "acknowledged_at" => nil,
                "address" => "147-149 Prichard Street Fitchburg, MA, 01420, USA",
                "closed_at" => nil,
                "comment_url" => "https://seeclickfix.com/api/v2/issues/8957626/comments",
                "created_at" => "2020-11-23T12:56:41-05:00",
                "description" => "missed Friday",
                "flag_url" => "https://seeclickfix.com/api/v2/issues/8957626/flag",
                "html_url" => "https://seeclickfix.com/issues/8957626",
                "id" => 8_957_626,
                "lat" => 42.5857019855574,
                "lng" => -71.8010439778683,
                "media" => %{
                  "image_full" => nil,
                  "image_square_100x100" => nil,
                  "representative_image_url" =>
                    "https://seeclickfix.com/assets/categories/trash-253f6f37c76ecf513079ab225a5a2acb301dc27c869c749bc6c592b779207bd5.png",
                  "video_url" => nil
                },
                "point" => %{
                  "coordinates" => [-71.8010439778683, 42.58570198555742],
                  "type" => "Point"
                },
                "private_visibility" => false,
                "rating" => 1,
                "reopened_at" => nil,
                "reporter" => %{
                  "avatar" => %{
                    "full" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png",
                    "square_100x100" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png"
                  },
                  "civic_points" => 0,
                  "html_url" => "https://seeclickfix.com/users/1287439",
                  "id" => 1_287_439,
                  "name" => "City of Fitchburg, MA Neighbor",
                  "role" => "Registered User",
                  "witty_title" => ""
                },
                "request_type" => %{
                  "id" => 7048,
                  "organization" => "Fitchburg, MA",
                  "related_issues_url" =>
                    "https://seeclickfix.com/api/v2/issues?lat=42.5857019855574&lng=-71.8010439778683&request_types=7048&sort=distance",
                  "title" => "Missed Trash, Recycling or Yard Waste Pickup",
                  "url" => "https://seeclickfix.com/api/v2/request_types/7048"
                },
                "shortened_url" => nil,
                "status" => "Open",
                "summary" => "Missed Trash, Recycling or Yard Waste Pickup",
                "transitions" => %{
                  "close_url" => "https://seeclickfix.com/api/v2/issues/8957626/close"
                },
                "updated_at" => "2020-11-23T12:56:42-05:00",
                "url" => "https://seeclickfix.com/api/v2/issues/8957626"
              }
            ],
            "metadata" => %{
              "pagination" => %{
                "entries" => 2,
                "next_page" => 2,
                "next_page_url" =>
                  "https://seeclickfix.com/api/v2/issues?page=2&per_page=1&place=albany-county&sort=update_at&sort_direction=DESC",
                "page" => 1,
                "pages" => 2,
                "per_page" => 1,
                "previous_page" => nil,
                "previous_page_url" => nil
              }
            }
          }
        }

      %{
        method: :get,
        url: "https://seeclickfix.com/api/v2/issues",
        query: [
          sort: "update_at",
          sort_direction: "DESC",
          per_page: 1,
          page: 2,
          place_url: "albany-county-two-pages"
        ]
      } ->
        %Tesla.Env{
          status: 200,
          body: %{
            "errors" => %{},
            "issues" => [
              %{
                "acknowledged_at" => nil,
                "address" => "115 S Grace St Crockett, TX, 75835, USA",
                "closed_at" => nil,
                "comment_url" => "https://seeclickfix.com/api/v2/issues/8958565/comments",
                "created_at" => "2020-11-23T15:46:27-05:00",
                "description" =>
                  "Sarah Clark reported a water leak behind her house at her fence she says the leak is coming from Lakeway or Twin Drive and really making saturating her back yard. She thinks it's on the City side. ",
                "flag_url" => "https://seeclickfix.com/api/v2/issues/8958565/flag",
                "html_url" => "https://seeclickfix.com/issues/8958565",
                "id" => 8_958_565,
                "lat" => 31.3196943014884,
                "lng" => -95.4435539245605,
                "media" => %{
                  "image_full" => nil,
                  "image_square_100x100" => nil,
                  "representative_image_url" =>
                    "https://seeclickfix.com/assets/categories_trans/no-image-af3faf07f478451d4ca455f92af96dd763f686e943607309ed059ef4fe13be21.png",
                  "video_url" => nil
                },
                "point" => %{
                  "coordinates" => [-95.44355392456055, 31.31969430148839],
                  "type" => "Point"
                },
                "private_visibility" => false,
                "rating" => 1,
                "reopened_at" => nil,
                "reporter" => %{
                  "avatar" => %{
                    "full" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png",
                    "square_100x100" =>
                      "https://seeclickfix.com/assets/no-avatar-100-4c3cf895b7ee80b7e97c54d1c7ee80ef9e8d176702efb9a7dcf02abb38ffa5b8.png"
                  },
                  "civic_points" => 0,
                  "html_url" => "https://seeclickfix.com/users/1529328",
                  "id" => 1_529_328,
                  "name" => "Crockett, TX Neighbor",
                  "role" => "Registered User",
                  "witty_title" => ""
                },
                "request_type" => %{
                  "id" => 22312,
                  "organization" => "Crockett, TX (Water Only)",
                  "related_issues_url" =>
                    "https://seeclickfix.com/api/v2/issues?lat=31.3196943014884&lng=-95.4435539245605&request_types=22312&sort=distance",
                  "title" => "Water Leak",
                  "url" => "https://seeclickfix.com/api/v2/request_types/22312"
                },
                "shortened_url" => nil,
                "status" => "Open",
                "summary" => "Water Leak",
                "transitions" => %{
                  "close_url" => "https://seeclickfix.com/api/v2/issues/8958565/close"
                },
                "updated_at" => "2020-11-23T15:46:28-05:00",
                "url" => "https://seeclickfix.com/api/v2/issues/8958565"
              }
            ],
            "metadata" => %{
              "pagination" => %{
                "entries" => 2,
                "next_page" => nil,
                "next_page_url" =>
                  "https://seeclickfix.com/api/v2/issues?page=2&per_page=1&place=albany-county&sort=update_at&sort_direction=DESC",
                "page" => 2,
                "pages" => 2,
                "per_page" => 1,
                "previous_page" => nil,
                "previous_page_url" => nil
              }
            }
          }
        }
    end)

    :ok
  end

  describe "list/1" do
    test "lists valid records" do
      client = ExSeeClickFix.Client.new("albany-county-single-page")

      assert ExSeeClickFix.Issues.list(client, per_page: 1) ==
               [
                 %ExSeeClickFix.Issue{
                   acknowledged_at: nil,
                   address: "147-149 Prichard Street Fitchburg, MA, 01420, USA",
                   closed_at: nil,
                   comment_url: "https://seeclickfix.com/api/v2/issues/8957626/comments",
                   created_at: ~U[2020-11-23 17:56:41Z],
                   description: "missed Friday",
                   flag_url: "https://seeclickfix.com/api/v2/issues/8957626/flag",
                   html_url: "https://seeclickfix.com/issues/8957626",
                   id: 8_957_626,
                   lat: 42.5857019855574,
                   lng: -71.8010439778683,
                   rating: 1,
                   shortened_url: nil,
                   status: "Open",
                   summary: "Missed Trash, Recycling or Yard Waste Pickup",
                   updated_at: ~U[2020-11-23 17:56:42Z],
                   url: "https://seeclickfix.com/api/v2/issues/8957626"
                 }
               ]
    end
  end

  describe "stream_list" do
    test "streams records from multiple pages" do
      client = ExSeeClickFix.Client.new("albany-county-two-pages")

      assert ExSeeClickFix.Issues.stream_list(client, per_page: 1) |> Enum.to_list() == [
               %ExSeeClickFix.Issue{
                 acknowledged_at: nil,
                 address: "147-149 Prichard Street Fitchburg, MA, 01420, USA",
                 closed_at: nil,
                 comment_url: "https://seeclickfix.com/api/v2/issues/8957626/comments",
                 created_at: ~U[2020-11-23 17:56:41Z],
                 description: "missed Friday",
                 flag_url: "https://seeclickfix.com/api/v2/issues/8957626/flag",
                 html_url: "https://seeclickfix.com/issues/8957626",
                 id: 8_957_626,
                 lat: 42.5857019855574,
                 lng: -71.8010439778683,
                 rating: 1,
                 shortened_url: nil,
                 status: "Open",
                 summary: "Missed Trash, Recycling or Yard Waste Pickup",
                 updated_at: ~U[2020-11-23 17:56:42Z],
                 url: "https://seeclickfix.com/api/v2/issues/8957626"
               },
               %ExSeeClickFix.Issue{
                 acknowledged_at: nil,
                 address: "115 S Grace St Crockett, TX, 75835, USA",
                 closed_at: nil,
                 comment_url: "https://seeclickfix.com/api/v2/issues/8958565/comments",
                 created_at: ~U[2020-11-23 20:46:27Z],
                 description:
                   "Sarah Clark reported a water leak behind her house at her fence she says the leak is coming from Lakeway or Twin Drive and really making saturating her back yard. She thinks it's on the City side. ",
                 flag_url: "https://seeclickfix.com/api/v2/issues/8958565/flag",
                 html_url: "https://seeclickfix.com/issues/8958565",
                 id: 8_958_565,
                 lat: 31.3196943014884,
                 lng: -95.4435539245605,
                 rating: 1,
                 shortened_url: nil,
                 status: "Open",
                 summary: "Water Leak",
                 updated_at: ~U[2020-11-23 20:46:28Z],
                 url: "https://seeclickfix.com/api/v2/issues/8958565"
               }
             ]
    end
  end
end
