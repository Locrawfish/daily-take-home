class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.string :room_name
      t.string :session_id
      t.decimal :recv_bits_per_sec
      t.decimal :send_bits_per_sec
      t.decimal :video_recv_bits_per_sec
      t.decimal :video_recv_packet_loss
      t.decimal :video_send_bits_per_second
      t.decimal :video_send_packet_loss
      t.decimal :worst_video_recv_packet_loss
      t.decimal :worst_video_send_packet_loss
      t.string :threshold
      t.integer :quality

      t.timestamps
    end
  end
end
