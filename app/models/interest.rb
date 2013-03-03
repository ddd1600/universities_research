class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
  # attr_accessible :title, :body
end
