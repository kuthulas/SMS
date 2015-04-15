Feature: Admin can login

Scenario: Admin Login
  Given I am on the Seminar Management System home page
  When I follow "Admin Login"
  Then I should be on the Admin Login page
  When I fill in "username" with "admin"
  When I fill in "password" with "admin123" 
  And I press "Log in"

  Then I should be on the Admin home page
  When I follow "Admin Logout"
  

 
