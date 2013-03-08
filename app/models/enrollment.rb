class Enrollment < ActiveRecord::Base
  attr_accessible :college_id, :full_time_students, :institution_id, :ipeds_unit_id, :ok, :part_time_students, :total_students, :year
  belongs_to :university
end
