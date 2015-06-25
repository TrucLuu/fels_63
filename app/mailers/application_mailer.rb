class ApplicationMailer < ActionMailer::Base
  default from: {with: Settings.setting.mail_default}
  layout "mailer"
end
