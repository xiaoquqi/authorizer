class Role < ActiveRecord::Base
  include ActsAsTree
  acts_as_tree order: "name"

  attr_accessible :name, :parent_id
end
