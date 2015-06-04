ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => ENV['SMTP_SERVER'] || 'smtp.sendgrid.net',
  :port           => ENV['SMTP_PORT']   || 587,
  :authentication => :plain,
  :user_name      => ENV['SMTP_USERNAME']   || ENV['SENDGRID_USERNAME'],
  :password       => ENV['SMTP_PASSWORD']   || ENV['SENDGRID_PASSWORD'],
  :domain         => ENV['SMTP_DOMAIN'] || ENV['SENDGRID_DOMAIN']
}

# Set config specific values
(ActionMailer::Base.default_url_options ||= {}).tap do |default|
  options_from_config = {
    host: Errbit::Config.host,
    port: Errbit::Config.port,
    protocol: Errbit::Config.protocol
  }.select { |k, v| v }

  default.reverse_merge!(options_from_config)
end
