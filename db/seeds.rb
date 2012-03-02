# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


puts "Creating 2 users..."
User.create([
  { :username => 'ion', :first_name => 'Jonathan', :last_name => 'Hernandez', :occupation => 'Coordinador y Desarrollador', :email => 'ion@cimav.edu.mx', :birth_date => '1977-10-23', :start_date => '2003-10-16'}, 
  { :username => 'claudia.lopez', :first_name => 'Claudia', :last_name => 'Lopez', :occupation => 'Soporte Técnico', :email => 'claudia.lopez@cimav.edu.mx', :birth_date => '1977-03-15', :start_date => '2000-01-01'}
])

puts "Groups..."
gt = GroupType.create([
  {:name => 'Tipo', :description => 'Tipo de persona (empleado, estudiante, honorarios, etc)', :position => 0, :required => 1, :display => 0 },
  {:name => 'Sede', :description => 'Sede donde se encuentra la persona', :position => 0, :required => 1, :display => 0 },
  {:name => 'Departamento', :description => 'Departamentos del CIMAV', :position => 1, :required => 1, :display => 1 },
  {:name => 'Equipos/Grupos', :description => 'Grupos de trabajo del CIMAV', :position => 2, :required => 0, :display => 1 },
  {:name => 'Proyectos', :description => 'Proyectos del CIMAV', :position => 3, :required => 0, :display => 1 }
])

Group.create([
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Empleado', :short_name => 'empleado', :position => 1 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Estudiante', :short_name => 'estudiante', :position => 2 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Servicio', :short_name => 'servicio', :position => 3 },
  {:group_type => GroupType.where(:name => 'Tipo').first, :name => 'Honorarios', :short_name => 'honorarios', :position => 4 },
  {:group_type => GroupType.where(:name => 'Sede').first, :name => 'Chihuahua', :short_name => 'chihuahua', :position => 1 },
  {:group_type => GroupType.where(:name => 'Sede').first, :name => 'Monterrey', :short_name => 'monterrey', :position => 2 },
  {:group_type => GroupType.where(:name => 'Departamento').first, :name => 'Recursos Humanos', :short_name => 'rh', :position => 1 },
  {:group_type => GroupType.where(:name => 'Departamento').first, :name => 'Tecnologías de Información y Comunicación', :short_name => 'tic', :position => 2 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Seguridad e Higiene', :short_name => 'seguridad-higiene', :position => 1 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Calidad', :short_name => 'calidad', :position => 2 },
  {:group_type => GroupType.where(:name => 'Equipos/Grupos').first, :name => 'Comunicación', :short_name => 'comunicacion', :position => 3 },
  {:group_type => GroupType.where(:name => 'Proyectos').first, :name => 'Test', :short_name => 'test', :position => 1 }
])

Membership.create([
  {:user => User.where('username' => 'ion').first, :group => Group.where(:short_name => 'tic').first, :can_publish => 1, :can_modify_others => 1 , :can_admin => 1}, 
  {:user => User.where('username' => 'ion').first, :group => Group.where(:short_name => 'tic').first, :can_publish => 1, :can_modify_others => 1 , :can_admin => 1}, 
  {:user => User.where('username' => 'claudia.lopez').first, :group => Group.where(:short_name => 'comunicacion').first, :can_publish => 1, :can_modify_others => 1 , :can_admin => 1}
])

puts "Post types..."
PostType.create([
  {:name => 'Mensaje', :short_name => 'message', :share_title => 'Mensaje'},
  {:name => 'Link', :short_name => 'link', :share_title => 'Link'},
  {:name => 'Foto', :short_name => 'photo', :share_title => 'Foto'},
  {:name => 'Archivos', :short_name => 'files', :share_title => 'Archivo'},
  {:name => 'Evento', :short_name => 'event', :share_title => 'Evento'}
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
