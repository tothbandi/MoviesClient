require 'uri'
require 'net/http'

class Communicator

  attr_accessor :keywords, :page

  def initialize keywords, page
    @keywords = keywords
    @page = page
  end

  def search_movie
    uri = URI(MOVIE_URL)

    params = { :query => keywords }
    params[:page] = page if page
    uri.query = URI.encode_www_form(params)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{TOKEN}"

    Rails.logger.info "GET #{ uri.to_s }"
    begin
      response = http.request(request)
      Rails.logger.info "#{ response.code } #{ response.message }"
      response
    rescue => exception
      Rails.logger.error exception.message
    end
  end
end
