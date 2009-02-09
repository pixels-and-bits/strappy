require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/home/index.html.erb" do
  include HomeHelper

  it "should not render the blackbird files" do
    render "/home/index.html.haml", :layout => 'application'
    response.should_not have_tag("link[href=?]", '/blackbird/blackbird.css')
  end

  it "should render the blackbird files when overridden" do
    session[:blackbird] = true
    render "/home/index.html.haml", :layout => 'application'
    response.should have_tag("link[href=?]", '/blackbird/blackbird.css')
  end
end
