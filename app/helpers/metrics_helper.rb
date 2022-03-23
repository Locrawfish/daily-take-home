module MetricsHelper
    # session data example: https://docs.daily.co/reference/rest-api/meetings
    def sum_duration_across_participants(session_data)
        # time in seconds, converted to minutes upon render
        total_time = 0 
        # iterate over all sessions
        session_data.each do |session|
          # grab participants
          participants = session["participants"]
            if participants
                # grab time for each participant
                participants.each do |participant|
                    total_time += participant["duration"]
                end
            end
        end
        # determine minutes, rounding to the complete minute
        time_mins = total_time.to_f/60
        time_mins.round()
      end
    end
