class AddFreshmenEnteringStatsColumnsToRoomAndBoards < ActiveRecord::Migration
  def change
    add_column :room_and_boards, :freshmen_entering, :integer
    add_column :room_and_boards , :total_entering_undergrads, :integer
  end
end
