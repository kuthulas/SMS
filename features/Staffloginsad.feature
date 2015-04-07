Feature: Staff can login

Scenario: Staff Login
  Given I am on the Seminar Management System home page
  When I follow "Staff Login"
  Then I should be on the Staff Login page
  When I fill in "username" with "wrong"
  When I fill in "password" with "wrongagain" 
  And I press "Log in"
  Then I should be on the Staff Login page
  And I should see "Invalid username or password."
  When I follow "Home"
  Then I should be on the home page
