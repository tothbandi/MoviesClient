##
# This class responsible to process movies list

class MoviesClient

  attr_reader :keywords, :page, :cached

  def initialize keywords, page
    @keywords = keywords
    @page = page
  end

  def search
    { response: response, counter: counter, cached: cached }
  end

  private

  def response
    @cached = true
    Rails.cache.fetch("#{keywords} page:#{page}", expires_in: 2.minutes) do
      @cached = false
      Communicator.new(keywords, page).search_movie
    end
  end

  def counter
    count = cached ? Rails.cache.read("#{keywords} page:#{page} counter") : -1
    count = count + 1
    Rails.cache.write("#{keywords} page:#{page} counter", count)
    count
  end
end

