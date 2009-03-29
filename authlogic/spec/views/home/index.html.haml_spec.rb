require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index.html.haml" do
  include HomeHelper
  fixtures :users
  setup :activate_authlogic

  it "should not render the blackbird files" do
    UserSession.create(users(:mmoen))(users(:mmoen))
    render "/home/index.html.haml", :layout => 'application'
    response.should_not have_tag("link[href=?]", '/blackbird/blackbird.css')
  end

  it "should render the blackbird files when overridden" do
    UserSession.create(users(:mmoen))(users(:mmoen))
    session[:blackbird] = true
    render "/home/index.html.haml", :layout => 'application'
    response.should have_tag("link[href=?]", '/blackbird/blackbird.css')
  end
end
