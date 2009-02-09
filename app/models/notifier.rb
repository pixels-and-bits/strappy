class Notifier < ActionMailer::Base
  default_url_options[:host] = SiteConfig.host_name

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "#{SiteConfig.app_name} Notifier <#{SiteConfig.email_from}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
end