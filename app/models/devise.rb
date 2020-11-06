Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'  

  ・・・
  config.scoped_views = true
  ・・・

end