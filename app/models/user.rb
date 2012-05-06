class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :fname, :lname, :login, :remember_token, :remember_token_expires_at, :salt
end
