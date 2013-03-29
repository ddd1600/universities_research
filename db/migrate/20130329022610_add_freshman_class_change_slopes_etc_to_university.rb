class AddFreshmanClassChangeSlopesEtcToUniversity < ActiveRecord::Migration
  def change
    add_column :universities, :full_time_students_slope, :float
    add_column :universities, :part_time_students_slope, :float
    add_column :universities, :total_students_slope, :float
    add_column :universities, :entering_freshmen_slope, :float
    add_column :universities, :total_entering_undergrads, :float
  end
end
