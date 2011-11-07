# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Project.delete_all
Role.delete_all


<<<<<<< HEAD
@admin = User.create! username: "admin", password: "admin", name: "Sereno", email: "admin@gmail.com", contact: "91 101 01 01"
@proj = Project.create! name: "Project XPTO", repo: "http://github.com/dcastro/mads2011.git"
=======
@admin = User.create! username: "admin", password: "admin", name: "Sereno", email: "b.boy.souljah@gmail.com", contact: "91 101 01 01"
@yuno = User.create! username: "yuno", password: "1234", name: "Yuno", email: "xyunox@gmail.com", contact: "91 11 11 111"

@proj = Project.create! name: "Project XPTO", repo: "github.com/dcastro/mads2011.git"
>>>>>>> c8a2ab99347c282c984ea7e8b5aa0cd39e799e06



@role = Role.create! user: @admin, project: @proj, name: "Manager"
@role = Role.create! user: @yuno, project: @proj, name: "Developer"

20.times do |x|
  User.create! username: "user" + x.to_s, password: "1234", name: "User " + x.to_s, email: x.to_s + "@gmail.com", contact: "91 101 01 01"
end


