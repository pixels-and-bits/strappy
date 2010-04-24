file_inject('config/application.rb',
  "  end",
  "    config.secret_token = '#{ActiveSupport::SecureRandom.hex(64)}'",
  :before
)
