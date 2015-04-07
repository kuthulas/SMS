Feature: Admin can login

Scenario: Admin Login
  Given I am on the Seminar Management System home page
  When I follow "Admin Login"
  Then I should be on the Admin Login page
  When I fill in "username" with "wrong"
  When I fill in "password" with "wrongagain" 
  And I press "Log in"
  Then I should be on the Admin Login page
  And I should see "Invalid username or password."

 
