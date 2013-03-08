class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :institution_id
      t.integer :year
      t.integer :full_time_students
      t.integer :part_time_students
      t.integer :total_students
      t.integer :ipeds_unit_id
      t.integer :college_id
      t.boolean :ok
      t.references :university

      t.timestamps
    end
  end
end
