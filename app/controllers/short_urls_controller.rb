class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index

    @urls = ShortUrl.order('click_count DESC').select(:id, :full_url, :title, :click_count, :short_code).first(100)

    render json: { urls: @urls}

  end

  def create
    
    short_url = ShortUrl.new
    short_url.full_url = params[:full_url]
    
    #only save on valid urls
    if short_url.save
      short_url.shorten_code
      render json: short_url
    else
      render json: short_url.errors
    end

  end

  def show
    url = ShortUrl.find_by(short_code: params[:id])
    
    if url
      url.update(click_count: url.click_count += 1) 
      redirect_to url.full_url
    else
      render :json => @error_object.to_json, :status => 404
    end
  end

 
  
end
