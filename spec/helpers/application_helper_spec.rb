require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  include ApplicationHelper
  fixtures :users

  it "should render the delete_img when passed a valid object" do
    res = delete_img(User.first, '/users/destroy/1')
    res.should =~ /_method=delete/
    res.should =~ /url:'\/users\/destroy\/1'/
  end

  it "should not render the delete_img when passed an invalid object" do
    res = delete_img(User.new, '/users/destroy/1')
    res.should be_nil
  end

  it "should render the edit_img when passed a valid object" do
    res = edit_img(User.first, '/users/1/edit')
    res.should =~ /href="\/users\/1\/edit"/
  end

  it "should not render the edit_img when passed an invalid object" do
    res = edit_img(User.new, '/users/1/edit')
    res.should be_nil
  end

  it "should render the sortable initialization code" do
    res = sortable('sortable_list', 'sortable_handle')
    res.should =~ /\$\('sortable_list ul'\)/
    res.should =~ /handle: 'sortable_handle'/
    res.should =~ /PNB.updateSortables\('sortable_list'\)/
  end

  it "should render a drag image" do
    res = drag_img
    res.should =~ /\/images\/arrow_up_down.png/
  end
end
