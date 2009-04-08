require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do

  it "should handle the blackbird override" do
    get :index, :force_blackbird => 'true'
    session[:blackbird].should be_true
  end

end
