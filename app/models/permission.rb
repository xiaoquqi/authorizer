class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity
  belongs_to :role
  attr_accessible :entity_id, :role_id, :user_id
  validates :entity_id, :presence => true
  validates :role_id, :presence => true
  validates :user_id, :presence => true
end
