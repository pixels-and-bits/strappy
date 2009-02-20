require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index.html.erb" do
  include HomeHelper
  fixtures :users

  it "should not render the blackbird files" do
    set_session_for(users(:mmoen))
    render "/home/index.html.haml", :layout => 'application'
    response.should_not have_tag("link[href=?]", '/blackbird/blackbird.css')
  end

  it "should render the blackbird files when overridden" do
    set_session_for(users(:mmoen))
    session[:blackbird] = true
    render "/home/index.html.haml", :layout => 'application'
    response.should have_tag("link[href=?]", '/blackbird/blackbird.css')
  end
end
