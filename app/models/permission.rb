class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity
  belongs_to :role
  # attr_accessible :title, :body
end
