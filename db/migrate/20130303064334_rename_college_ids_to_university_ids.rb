class RenameCollegeIdsToUniversityIds < ActiveRecord::Migration
  def change
    rename_column :core_expenses, :college_id, :university_id
    rename_column :core_revenues, :college_id, :university_id
    rename_column :freshman_stats, :college_id, :university_id
    rename_column :room_and_boards, :college_id, :university_id
  end
end
