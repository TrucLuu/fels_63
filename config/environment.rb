# Load the Rails application.
require File.expand_path('../application', __FILE__)

Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {host: "localhost:3000"}
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: ENV["gmail_username"],
    password: ENV["gmail_password"],
    authentication: "plain",
    enable_starttls_auto: true
  }  
end

# Initialize the Rails application.
Rails.application.initialize!
