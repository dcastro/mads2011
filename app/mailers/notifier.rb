class Notifier < ActionMailer::Base
  default from: "admin@bddcucumber.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.project_deleted.subject
  #
  def project_deleted(project, admin, destination)
    @project = project
    @admin = admin

    mail to: destination
  end
end
