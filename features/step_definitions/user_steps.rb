### UTILITY METHODS ###
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

############################## Admin login logout ####################################################
def create_admin
    
    @adminvisit ||= { :username => "admin", :email => "kumaranraman@gmail.com",
    :password => "admin123", :password_confirmation => "admin123" }
end

def find_auser
  @admin ||= Admin.where(:email => @adminvisit[:email]).first
end

def create_unconfirmed_auser
  create_admin
  delete_auser
  asign_up
  visit '/admins/sign_out'
end

def create_auser
  create_admin
  delete_auser
  @admin = Admin.create(@adminvisit)
   
end

def delete_auser
  @admin ||= Admin.where(:email => @adminvisit[:email]).first
  @admin.destroy unless @admin.nil?
end

def asign_up
  delete_auser
  visit '/admins/sign_up'
  fill_in "admin_username", :with => @adminvisit[:username]
  fill_in "admin_email", :with => @adminvisit[:email]
  fill_in "admin_password", :with => @adminvisit[:password]
  fill_in "admin_password_confirmation", :with => @adminvisit[:password_confirmation]
  click_button "Sign up"
  find_auser
end

def asign_in
  visit '/admins/sign_in'
  fill_in "admin_username", :with => @adminvisit[:username]
  fill_in "admin_password", :with => @adminvisit[:password]
  click_button "Log in"
end
############################################### Staff Signin Signout ##########################################################
def create_visitor
  @visitor ||= { :username => "testy", :email => "example@example.com",
    :password => "changeme", :password_confirmation => "changeme" }
end

def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = User.create(@visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_username", :with => @visitor[:username]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Log in"
end
#########################################Staff end##########################################################
### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end
Given /^I am not logged in as admin$/ do
  visit '/admins/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I am logged in as admin$/ do
  create_auser
  asign_in
end

Given /^I exist as a user$/ do
  create_user
end
Given /^I exist as a admin$/ do
  create_auser
end
Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end
Given /^I do not exist as a admin$/ do
  create_admin
  delete_auser
end
Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_auser
end

### WHEN ###

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end
When /^I sign in with valid credentials as admin$/ do
  create_admin
  asign_in
end

When /^I sign out$/ do
  page.driver.submit :delete, '/users/sign_out', {}
end
When /^I sign out as admin$/ do
  page.driver.submit :delete, '/admins/sign_out', {}
end
When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end
When /^I sign up with valid admin data$/ do
  create_admin
  asign_up
end
When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end
When /^I sign up with an invalid email as admin$/ do
  create_admin
  @adminvisit = @adminvisit.merge(:email => "notanemail")
  asign_up
end
When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end
When /^I sign up without a password confirmation as admin$/ do
  create_admin
  @adminvisit = @adminvisit.merge(:password_confirmation => "")
  asign_up
end
When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end
When /^I sign up without a password as admin$/ do
  create_admin
  @adminvisit = @adminvisit.merge(:password => "")
  asign_up
end
When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end
When /^I sign up with a mismatched password confirmation as admin$/ do
  create_admin
  @adminvisit = @adminvisit.merge(:password_confirmation => "admin123")
  asign_up
end
When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end
When /^I sign in with a wrong password as admin$/ do
  @adminvisit = @adminvisit.merge(:password => "wrongpass")
  asign_in
end
When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

When(/^I follow Students$/) do
  visit '/students' 
end
When(/^I press Enter$/) do
 find(:id, 'card').native.send_keys(:enter)
end


### THEN ###
Then /^I should be signed in$/ do
  expect(page).to have_content "Logged in as: #{@user[:username]}"
  expect(page).to have_no_content "Staff Login"
end
Then /^I should be signed in as admin$/ do
  expect(page).to have_content "Logged in as: #{@admin[:username]}"
  expect(page).to have_no_content "Admin Login"
end
Then /^I should be signed out$/ do
  expect(page).to have_content "Staff Login"
  expect(page).to have_no_content "Logout"
end
Then /^I should be signed out as admin$/ do
  expect(page).to have_content "Admin Login"
  expect(page).to have_no_content "Logout"
end
Then /^I see an unconfirmed account message$/ do
  expect(page).to have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  expect(page).to have_content "Logged in as: #{@user[:username]}"
end
Then /^I see a successful sign in message as admin$/ do
  expect(page).to have_content "Logged in as: #{@admin[:username]}"
end
Then /^I should see a successful sign up message$/ do
  expect(page).to have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  expect(page).to have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  expect(page).to have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  expect(page).to have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  expect(page).to have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  expect(page).to have_content "Welcome! Please log in to continue"
end

Then /^I see an invalid login message$/ do
  expect(page).to have_content "Invalid username or password."
end

Then /^I should see an account edited message$/ do
  expect(page).to have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  expect(page).to have_content @user[:username]
end

Then(/^I should see the Students page$/) do 
  expect(page).to have_content "Listing Students"
end
Then(/^I should see the Cards page$/) do
  expect(page).to have_content "Import Card Data"
end

When(/^I follow Edit$/) do
  visit '/students/1/edit'
end

When(/^I follow Show user$/) do
  visit 'users/1'
end

When(/^I follow Edit user$/) do
  visit 'users/1/edit'
end


