# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Users.create([
  { :username => 'ion', :first_name => 'Jonathan', :last_name => 'Hernandez', 'Coordinador y Desarrollador', 'ion@cimav.edu.mx', :birth_date => '1977-10-23'}, 
  { :username => 'claudia.lopez', :first_name => 'Claudia', :last_name => 'Lopez', 'Soporte Técnico', 'claudia.lopez@cimav.edu.mx', :birth_date => '1977-03-15'}
])
