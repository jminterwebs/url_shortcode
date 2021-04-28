class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    short_url = ShortUrl.new
    short_url.full_url = params[:full_url]
    
    #only save on valid urls

    if short_url.save
      render json: short_url
    else
      render json: short_url.errors
    end

  end

  def show
  end

end
