class AddSupplyMinusDemandDataToRoomAndBoards < ActiveRecord::Migration
  def change
    add_column :room_and_boards, :dorm_capacity_minus_entering_freshman_class_size, :integer
    add_column :room_and_boards, :entering_freshman_class_minus_dorm_capacity, :integer
    add_column :room_and_boards, :dorm_capacity_minus_total_entering_undergrads, :integer
    add_column :room_and_boards, :total_entering_undergrads_minus_dorm_capacity, :integer
  end
end
