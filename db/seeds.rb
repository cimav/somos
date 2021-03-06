# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


puts "Creating 2 users..."
User.create([
  { :username => 'ion', :first_name => 'Jonathan', :last_name => 'Hernandez Montes', :occupation => 'Coordinador y Desarrollador', :email => 'ion@cimav.edu.mx', :birth_date => '1977-10-23', :start_date => '2003-10-16', :display_name => 'Jonathan Hernández'}, 
  { :username => 'claudia.lopez', :first_name => 'Claudia', :last_name => 'Lopez', :occupation => 'Soporte Técnico', :email => 'claudia.lopez@cimav.edu.mx', :birth_date => '1977-03-15', :start_date => '2000-01-01', :display_name => 'Claudia López'}
])

puts "Groups..."
gt = GroupType.create([
  {:name => 'Tipo', :description => 'Tipo de persona (empleado, estudiante, honorarios, etc)', :position => 0, :required => 1, :display_in => 0 },
  {:name => 'Sede', :description => 'Sede donde se encuentra la persona', :position => 0, :required => 1, :display_in => 0 },
  {:name => 'Departamento', :description => 'Departamentos del CIMAV', :position => 1, :required => 1, :display_in => 1 },
  {:name => 'Equipos/Grupos', :description => 'Grupos de trabajo del CIMAV', :position => 2, :required => 0, :display_in => 1 },
  {:name => 'Proyectos', :description => 'Proyectos del CIMAV', :position => 3, :required => 0, :display_in => 1 }
])

Group.create([
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Empleado', :short_name => 'empleado', :position => 1 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Estudiante', :short_name => 'estudiante', :position => 2 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Servicio', :short_name => 'servicio', :position => 3 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Honorarios', :short_name => 'honorarios', :position => 4 },
  {:group_type => GroupType.where(:name => 'Sede').first, :name => 'Chihuahua', :short_name => 'chihuahua', :position => 1 },
  {:group_type => GroupType.where(:name => 'Sede').first, :name => 'Monterrey', :short_name => 'monterrey', :position => 2 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Seguridad e Higiene', :short_name => 'seguridad-higiene', :position => 1 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Calidad', :short_name => 'calidad', :position => 2 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Comunicación', :short_name => 'comunicacion', :position => 3 },
])

puts "Post types..."
PostType.create([
  {:name => 'message', :category => 0},
  {:name => 'link',  :category => 0},
  {:name => 'photo', :category => 0},
  {:name => 'file',  :category => 0},
  {:name => 'event', :category => 0},
  {:name => 'birthday', :category => 1},
  {:name => 'badge', :category => 1},
  {:name => 'productivity', :category => 1}
])


puts "Populating Countries..."
Country.delete_all
open("db/seeds/countries.txt") do |countries|
    countries.read.each_line do |country|
        code, name = country.chomp.split("|")
        Country.create!(:name => name, :code => code)
    end
end

puts "Populating States..."
State.delete_all
open("db/seeds/states.txt") do |states|
    states.read.each_line do |state|
        code, name = state.chomp.split("|")
        State.create!(:name => name, :code => code)
    end
end
