# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)
@usr
@admin_user
@first_project
@second_project
@third_project
@lz
Given /^the following users exist:$/ do |table|
  table.hashes.each do |user_hash|
    User.create(user_hash);
  end
end
Given /^the following projects exist:$/ do |table|
  table.hashes.each do |project_hash|
    # This needs to be generalized
    @usr.create_project(project_hash)
    #Project.new(project_hash).save;
  end
end

Given /^a set of users exist$/ do
#  User.create({"username"=>"admin", "email"=>"admin@gmail.com", "first"=>"admin", "last"=>"admin", "admin"=>"true", "password"=>"admin", "status"=>"active", "admin" => true})

  @admin_user = User.create("username" => "admin", :email => "admin@gmail.com", "first" => "ADMIN", "last" => "ACCOUNT", :password => :admin, :status => "active")
  @admin_user.admin = true; @admin_user.save

  User.create({"username" => "ag", "email"=>"anna@gmail.com", "first" => "Anensshiya", "last" => "Govinthasamy", "admin" => "true", "password" => "agovinthasamy", "status" => "active"})
#Elise: retired user
  User.create({"username" => "em", "email" => "elise@gmail.com", "first" => "Elise", "last" => "McCallum", "admin" => "false", "password" => "emccallum", "status" => "retired"})
#Jason: non-admin, project owner of Second project
  User.create({"username" => "jt", "email" => "jason@gmail.com", "first" => "Jason", "last" => "Teoh", "admin" => "false", "password" => "jteoh", "status" => "active"})
#Linda: non-admin, project member of Second project
  @lz = User.create({"username" => "lz", "email" => "linda@gmail.com", "first" => "Lingbo", "last" => "Zhang", "admin" => "false", "password" => "lzhang", "status" => "active"})
#Sherry: non-admin, project owner of Third project
  User.create({"username" => "bobw", "email" => "bob@gmail.com", "first" => "Sherry", "last" => "Wong", "admin" => "false", "password" => "swong", "status" => "active"})
end

Given /^a set of projects exist$/ do
  #coordinators, project_id, start, end
  @first_project = @usr.create_project({"name" => "First Project", "prefix" => "proj1", "description" => "P1", "owner_username" => "admin"})
  @first_project.add_members(User.find_all_by_status("active").map {|x| x.id})

  @second_project = @usr.create_project({"name" => "Second Project", "prefix" => "proj2", "description" => "P2", "owner_username" => "jt"})
  @second_project.add_members(Array[@lz.id])

  @third_project = @usr.create_project({"name" => "Third Project", "prefix" => "proj3", "description" => "P3", "owner_username" => "bobw"})
  @third_project.add_members(User.find_all_by_status("active").map {|x| x.id})
end

Given /^a set of risks exist$/ do
  #coordinators, project_id, start, end, risk_id, originator
  Risk.create_risk(@admin_user.id, @first_project.id, {:title => "First Risk", :owner_id=>"admin" , :description => "Risk1 for P1", :probability => 2, :cost => 3, :schedule => 2, :technical => 1, :status=>"active", :early_impact => "2008-11-20", :last_impact=> "2013-10-20"})
  Risk.create_risk(@admin_user.id, @first_project.id, {:title => "Second Risk", :owner_id=>"jt" , :description => "Risk2 for P1", :probability => 2, :cost => 3, :schedule => 2, :technical => 1, :status=>"active", :early_impact => "2008-11-20", :last_impact=> "2013-10-20"})
  Risk.create_risk(@admin_user.id, @second_project.id, {:title => "Third Risk", :owner_id=>"admin" , :description => "Risk3 for P1", :probability => 2, :cost => 3, :schedule => 2, :technical => 1, :status=>"active", :early_impact => "2008-11-20", :last_impact=> "2013-10-20"})
end

Given /^I am logged in as (.+)$/ do |user|
  visit '/'
  if user == "an admin"
    fill_in 'username', :with => 'admin'
    fill_in 'password', :with => 'admin'
  elsif user == "Linda"
    fill_in 'username', :with => 'lz'
    fill_in 'password', :with => 'lzhang'
  elsif user == "Jason"
    fill_in 'username', :with => 'jt'
    fill_in 'password', :with => 'jteoh'
  elsif user == "Sherry"
    fill_in 'username', :with => 'bobw'
    fill_in 'password', :with => 'swong'
  end
  click_button 'Login'
  @usr = User.find_by_username('admin')
  if page.respond_to? :should
    page.should have_content("My Projects")
  else
    page.should have_content?("My Projects")
  end
end

Given /^I am not logged in$/ do
  visit '/user/index'
  if page.body =~ /My Projects/
    click_button 'Logout'
  end
  page.should have_content("Login")
end

Given /^I log out$/ do
  visit '/user/logout'
end


# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

And /^(?:|I )click on deactivate user for "([^"]*)"$/ do |user|
  visit("/user/destroy?uid=" + User.find_by_username(user).id.to_s)
end

And /^(?:|I )click on deactivate project for "([^"]*)"$/ do |project|
  visit("/project/destroy?pid=" + Project.find_by_name(project).id.to_s)
end

And /^(?:|I )click on deactivate risk for "([^"]*)" in "([^"]*)"$/ do |risk, project|
  visit("/project/" + Project.find_by_name(project).id.to_s + "/risk/destroy?rid=" + Risk.find_by_title(risk).id.to_s)
end

And /^(?:|I )click on delete project member "([^"]*)" for "([^"]*)"$/ do |user, project|
  visit("/project/" + Project.find_by_name(project).id.to_s + "/remove_member?uid=" + User.find_by_username(user).id.to_s)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

And /"([^"]*)" should be retired$/ do |user|
  #visit path_to("/user/destroy?uid=" + User.find_by_username(user).id.to_s)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^there should not be deactivate project for "([^"]*)"$/ do |project|
  page.body.match /<tr>.*\/#{project}\/.*N\/A.*<\/tr>/
end

Then /^there should not be deactivate risk for "([^"]*)"$/ do |risk|
  page.body.match /<tr>.*\/#{risk}\/.*N\/A.*<\/tr>/
end

Then /^there should not be deactivate user for "([^"]*)"$/ do |user|
  page.body.match /<tr>.*\/#{user}\/.*N\/A.*<\/tr>/
end

Then /^there should be this message: "([^"]*)"$/ do |error|
  page.body.include?(error)
end

Then /^(?:|I )sort users by "([^"]*)"$/ do |field|
  visit ('/user/show_users?sort=' + field.to_s)
end

Then /^(?:|I )sort projects by "([^"]*)"$/ do |field|
  visit ('/user/index?sort=' + field.to_s)
end

Then /^(?:|I )sort "([^"]*)" project members by "([^"]*)"$/ do |project, field|
  visit ('/project/' + Project.find_by_name(project).id.to_s + '/edit?sort=' + field.to_s)
end

Then /^(?:|I )sort risks for "([^"]*)" by "([^"]*)"$/ do |project, field|
  visit ('/user/project/' + Project.find_by_name(project).id.to_s + '/risk/index?sort=' + field.to_s)
end

Then /^there should a log on field "([^"]*)" with old value "([^"]*)" and new value "([^"]*)"$/ do |field, oldV, newV|
  page.body.match /<tr class="info">.*\/#{field}\/.*\/#{oldV}\/.*\/#{newV}\/.*<\/tr>/
end

Then /^(?:|I )should not be able to fill in "([^"]*)"$/ do |field|
  page.body.match /input id="#{field}".*type="hidden"/
end
