class Role < ActiveRecord::Base
  include ActsAsTree
  acts_as_tree order: "name"

  has_many :permissions, :dependent => :destroy
  has_many :users, :through => :permissions
  has_many :entities, :through => :permissions

  validates :name,
    :presence => true,
    :uniqueness => true,
    :format => { :with => /^[A-Za-z0-9]*?$/ }

  attr_accessible :name, :parent_id
end
