class University < ActiveRecord::Base
  # attr_accessible :title, :body
  [:core_expenses, :core_revenues, :freshman_stats, :room_and_boards].each do |x|
    has_many x
  end
  has_many :users, :through => :interests
end
