require "test_helper"
require 'webmock/minitest'

class ApplicationControllerTest < ActionDispatch::IntegrationTest

  test 'search' do
    Rails.cache = ActiveSupport::Cache::MemoryStore.new
    response_body = {
      'page': 1,
      'results': [
        {
          'adult': false,
          'backdrop_path': '/rMQWqJoqXkeN1mo05gai1krRSLZ.jpg',
          'genre_ids': [
            27
          ],
          'id': 541100,
          'original_language': 'en',
          'original_title': 'Thriller',
          'overview': 'Years after a childhood prank goes horribly wrong, a clique of South Central LA teens find themselves terrorized during Homecoming weekend by a killer hell-bent on revenge.',
          'popularity': 7.012,
          'poster_path': '/mliD95nVqBijPGQdZ3xcg8Nsagu.jpg',
          'release_date': '2018-09-23',
          'title': 'Thriller',
          'video': false,
          'vote_average': 4.2,
          'vote_count': 29
        },
      ],
      'total_pages': 1,
      'total_results': 1
    }
    stub_request(:get, "#{MOVIE_URL}?page=1&query=thriller").
    with(
      headers: {
      'Accept'=>'application/json',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=> "Bearer #{TOKEN}",
      'Host'=>"#{URI(MOVIE_URL).host}",
      'User-Agent'=>'Ruby'
      }
    ).
    to_return status: 200, body: response_body.to_json, headers: {}
    
    now = Time.now

    get_movies now, 'Results downloaded from 3rd party API.', response_body
    get_movies now + 1.minutes, 'Results downloaded from temporary store.', response_body
    get_movies now + 121.seconds, 'Results downloaded from 3rd party API.', response_body

    Timecop.return
  ensure
    store = Rails.application.config.cache_store
    Rails.cache = ActiveSupport::Cache.lookup_store store
  end

  def get_movies time, flash_notice, response_body
    Timecop.freeze time
    get search_url, params: { keywords: 'thriller', page: 1 } 
    assert_response :success
    assert_equal flash_notice, flash[:notice]
    assert_select 'div', flash_notice
    assert_select 'div', response_body[:results][0][:original_title]
  end
end