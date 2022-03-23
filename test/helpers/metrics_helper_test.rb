require "test_helper"
require "json"

class MetricsHelperTest < ActiveSupport::TestCase
    include MetricsHelper
    session_data_with_participants = '[{
        "id": "82b92a0b-52cf-4495-f1bf-4d58a98a99b7",
        "room": "room-3",
        "start_time": 1549391714,
        "duration": 1650,
        "ongoing": true,
        "participants": [
            {
              "user_id": "bc165dbf-1d77-4c42-8ef0-bacfbbf0c8f7",
              "user_name": "Tester 1",
              "join_time": 1549391690,
              "duration": 1626
            },
            {
              "user_id": "bc165dbf-1d77-4c42-8ef0-bacfbbf0c8f4",
              "user_name": "Tester 2",
              "join_time": 1549391714,
              "duration": 1650
            }
          ]
        }]'
       
  test "should return 55 mins" do
    # (1650 + 1626)/60 = 54.6, rounds up to 55
    session_data = JSON.parse(session_data_with_participants)
    assert_equal 55, sum_duration_across_participants(session_data)
  end

  session_data_without_participants = '[{
    "id": "82b92a0b-52cf-4495-f1bf-4d58a98a99b7",
    "room": "room-3",
    "start_time": 1549391714,
    "duration": 1650,
    "ongoing": true,
    "participants": []
    }]'
    test "should return 0" do
        session_data = JSON.parse(session_data_without_participants)
        assert_equal 0, sum_duration_across_participants(session_data)
    end
end