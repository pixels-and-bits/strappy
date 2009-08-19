require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users

  describe "changing password" do
    it "should succeed without a confirmation field" do
      user = users(:mmoen)
      user.password = 'some new password'
      user.save!
    end
  end
end