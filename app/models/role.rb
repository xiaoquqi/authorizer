class Role < ActiveRecord::Base
  attr_accessible :name, :parent_id
end
