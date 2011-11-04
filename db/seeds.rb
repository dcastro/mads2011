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


@admin = User.create! username: "admin", password: "admin", name: "Sereno", email: "admin@gmail.com", contact: "91 101 01 01"
@proj = Project.create! name: "Project XPTO", repo: "github.com/dcastro/mads2011.git"

@role = Role.create! user: @admin, project: @proj, name: "Manager"



