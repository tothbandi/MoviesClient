class ApplicationController < ActionController::Base
  def index; end

  def search
    data = MoviesClient.new(permitted_params[:keywords], permitted_params[:page]).search
    response = data[:response]
    result = JSON.parse(response.body)
    if response.code == '200'
      @keywords = permitted_params[:keywords]
      @movies = result['results']
      @count = data[:counter].to_i
      @cached = data[:cached]
      @page = result['page'].to_i
      @pages = result['total_pages'].to_i
      info = "Results downloaded from #{@cached ? 'temporary store' : '3rd party API'}."
      flash[:notice] = info
    else
      flash[:notice] = "3rd party API message: #{result['status_message']}"
    end
    render :index
  end

  private

  def permitted_params
    params.permit(:keywords, :page)
  end
end
