class CoreExpense < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :university
end
