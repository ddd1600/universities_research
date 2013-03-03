class CreateFreshmanStats < ActiveRecord::Migration
  def change
    ary = [[:id, "integer"], [:year, "integer"], [:ipeds_id, "integer"], [:university_id, "integer"], [:freshmen_entering, "integer"], [:total_entering_undergrads, "integer"], [:created_at, "datetime"], [:updated_at, "datetime"], [:ok, "boolean"]]
    create_table :freshman_stats do |t|
     ary.each do |a|
        eval("t.#{a[1]} a[0]")
      end

      t.timestamps
    end
  end
end
