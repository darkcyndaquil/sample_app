class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  before_save { self.email = email.downcase }
  #validates the presence of a name attribute
  validates :name, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGEX =/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
  
  #changes user email to lowercase to check for uniqueness
  
  has_secure_password
  validates :password, length: {minimum: 6} 
  
  end
