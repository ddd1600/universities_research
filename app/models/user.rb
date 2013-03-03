class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  validates_uniqueness_of :email
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :universities, :through => :interests
end
