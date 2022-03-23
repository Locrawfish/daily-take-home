class VideosController < ApplicationController
  # this is needed because of CSRF is always on for Rails --since this is a toy project, I'm gonna remove this functionality
  protect_from_forgery with: :null_session
  BASE_ROOMS_URI = 'https://api.daily.co/v1/rooms'

  def index
  end

  def show
  end

  def create
    # grab api key and room name from the form
    api_key = params[:apikey]
    @room_name = params[:room_name]

    # i want to remove this and compartmentalize it.
    # set the options for the request
    options = {
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer #{api_key}",
      },
      body: { name: @room_name }.to_json
    }
    # make the request
    res = HTTParty.post(BASE_ROOMS_URI, options)

    #handle different results
    case res.code
    when 200
      @url = res.parsed_response["url"]
      render :show
    else
      render json: {status: "error", code: res.code, error: res.parsed_response["error"], message: res.parsed_response["info"]}
    end 
  end
end