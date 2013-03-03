class CreateRoomAndBoards < ActiveRecord::Migration
  def change
    ary = [[:id, "integer"], [:year, "integer"], [:ipeds_id, "integer"], [:university_id, "integer"], [:total_dormroom_capacity, "integer"], [:avg_room_cost_per_year, "integer"], [:created_at, "datetime"], [:updated_at, "datetime"], [:ok, "boolean"]]
    create_table :room_and_boards do |t|
      create_table :room_and_boards do |t|
      ary.each do |a|
        eval("t.#{a[1]} a[0]")
      end
      t.timestamps
    end
    end
  end
end
