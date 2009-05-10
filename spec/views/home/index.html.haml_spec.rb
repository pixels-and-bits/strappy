require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index.html.haml" do
  include HomeHelper
  fixtures :users
  setup :activate_authlogic

  it "should render the blackbird files when overridden" do
    UserSession.create(users(:mmoen))
    session[:blackbird] = true
    render "/home/index.html.haml", :layout => 'application'
  end

  it "should NOT use the google apis for production" do
    # yes I know that setting this here throws a warning, but it needs to be
    # run in a production context, open to suggestions
    UserSession.create(users(:mmoen))
    render "/home/index.html.haml", :layout => 'application'
    response.should_not have_tag("script[src=?]",
      'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js')
    response.should_not have_tag("script[src=?]",
      'http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js')
  end

  it "should use the google apis for production" do
    # yes I know that setting this here throws a warning, but it needs to be
    # run in a production context, open to suggestions
    RAILS_ENV = 'production'
    UserSession.create(users(:mmoen))
    render "/home/index.html.haml", :layout => 'application'
    response.should have_tag("script[src=?]",
      'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js')
    response.should have_tag("script[src=?]",
      'http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js')
  end
end
