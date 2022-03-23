class MetricsController < ApplicationController
  include MetricsHelper
  include HTTParty

  # this is needed because of CSRF is always on for Rails --since this is a toy project, I'm gonna remove this functionality
  protect_from_forgery with: :null_session
  BASE_MEETINGS_URI = 'https://api.daily.co/v1/meetings'

  def index
  end

  def show
    room_name = params[:room_name]
    metrics = Metric.find_by(room_name: room_name)
    if metrics
      render :json => metrics
    else
      render :json => {status: "error", code: 404, message: "No sessions find associated with that name."}
    end
  end

  def create
    # get data and insert into model
    stats = params[:stats]
    latest_stats = stats[:latest]
    
    metrics = Metric.new()
    metrics.room_name = params[:room_name]
    metrics.session_id = params[:session_id]
    metrics.recv_bits_per_sec = latest_stats[:recvBitsPerSecond]
    metrics.send_bits_per_sec = latest_stats[:sendBitsPerSecond]
    metrics.video_recv_bits_per_sec = latest_stats[:videoRecvBitsPerSecond]
    metrics.video_recv_packet_loss = latest_stats[:videoRecvPacketLoss]
    metrics.video_send_bits_per_second = latest_stats[:videoSendBitsPerSecond]
    metrics.video_send_packet_loss = latest_stats[:videoSendPacketLoss]
    metrics.worst_video_recv_packet_loss = stats[:worstVideoRecvPacketLoss]
    metrics.worst_video_send_packet_loss = stats[:worstVideoSendPacketLoss]
    metrics.threshold = params[:threshold]
    metrics.quality = params[:quality]
    #todo add date created

    metrics.save
  end

  # this function calls out to the Daily /meetings API to get duration of all sessions of all rooms
  # params to get total time are: start and end time
  # duration is calculated after recieving the response. this would not scale at all. :P 
  def get_total_participant_time
    # grab api key and room name from the form
    api_key = params[:apikey]
    room_name = params[:room_name]
    # .to_time.to_i used to convert Datetime to unix timestamp needed for query params
    timeframe_start = params[:start_time].to_time.to_i
    timeframe_end = params[:end_time].to_time.to_i

    # set the headers for the request
    headers = {
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer #{api_key}",
      }
    }

    query_params = "?room=#{room_name}&timeframe_start=#{timeframe_start}&timeframe_end=#{timeframe_end}"
    url = BASE_MEETINGS_URI+query_params
    # make the request
    res = HTTParty.get(url, headers)

    session_data = res["data"]
    total_time = sum_duration_across_participants(session_data)
    
    render :json => {total_time: total_time}
  end
end