class Entity < ActiveRecord::Base
  include ActsAsTree
  acts_as_tree order: "name"

  has_many :permissions, :dependent => :destroy
  has_many :users, :through => :permissions
  has_many :roles, :through => :permissions

  validates :name,
    :presence => true,
    :format => { :with => /^[A-Za-z0-9]*?$/ }
  validate :unique_name
  attr_accessible :name, :parent_id

  # Make sure name is unique in a particular branch
  def unique_name
    entity = Entity.where(
      :name => self.name,
      :parent_id => self.parent_id
    )
    if entity.blank?
      return true
    else
      errors.add( :base, "Entity already exist..." )
    end
  end # end unique_name

  # Find the full path up to root
  def full_path
    entity = Entity.find( self.id )
    full_name = entity.name
    while !( entity.parent.nil? )
      entity = entity.parent
      full_name = entity.name + "-" + full_name
    end
    return full_name
  end # end full_path
end
