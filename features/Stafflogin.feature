Feature: Staff can login

Scenario: Admin Login
  Given I am on the Seminar Management System home page
  When I follow "Staff Login"
  Then I should be on the Staff Login page
  When I fill in "username" with "staff"
  When I fill in "password" with "staff123" 
  And I press "Log in"
  Then I should be on the Staff home page
  When I follow "Staff Logout"
  

 
