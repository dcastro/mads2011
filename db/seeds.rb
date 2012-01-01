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
Feature.delete_all
Scenario.delete_all
Step.delete_all
StepRow.delete_all
StepCell.delete_all
Comment.delete_all
SuggestionScenario.delete_all
SuggestionStep.delete_all
SuggestionRow.delete_all
SuggestionCell.delete_all
ImplementedStep.delete_all
Example.delete_all
ExampleRow.delete_all
ExampleCell.delete_all



@admin = User.create! username: "admin", password: "admin", name: "Administrador", email: "b.boy.souljah@gmail.com", contact: "91 101 01 01"


@proj = Project.create! name: "iTest", github_username: "dcastro", github_repo: "mads2011", script: "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"
@proj_teste = Project.create! name: "Test Project", github_username: "dcastro", github_repo: "teste", script: "bundle install\r\nbundle exec rake db:setup RAILS_ENV=test"

@role = Role.create! user: @admin, project: @proj, name: "Manager"
@role = Role.create! user: @admin, project: @proj_teste, name: "Manager"

20.times do |x|
  User.create! username: "user" + x.to_s, password: "1234", name: "User " + x.to_s, email: x.to_s + "@gmail.com", contact: "91 101 01 01"
end


