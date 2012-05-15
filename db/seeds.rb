# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
root_entity = Entity.where( :name => "Authorizer" ).first_or_create

user = User.where( :login => "admin" ).first_or_create(
  "login" => "admin",
  "password" => "admin"
)

role = Role.where( :name => "Admin" ).first_or_create

permission = Permission.where(
  :user_id => user.id,
  :entity_id => root_entity.id,
  :role_id => role.id
).first_or_create
