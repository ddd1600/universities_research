class AddColumnsToRoomAndBoards < ActiveRecord::Migration
  def change
    ary = [[:year, "integer"], [:ipeds_id, "integer"], [:college_id, "integer"], [:total_dormroom_capacity, "integer"], [:avg_room_cost_per_year, "integer"], [:created_at, "datetime"], [:updated_at, "datetime"], [:ok, "boolean"]]
    ary.each do |a|
      add_column :room_and_boards, a[0], a[1].to_sym
    end
  end
end
