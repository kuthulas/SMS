Feature: Manage Staff as a admin

Scenario: Add a user
   Given I am logged in as admin
   When I follow "Manage Users"
   Then I should see "Manage Check-in Staff"
   When I follow "New User"
   Then I should see "Sign up"
   When I fill in "Username" with "stafftest"
   When I fill in "Email" with "staff@test.com"
   When I fill in "Password" with "staff123"
   When I fill in "Retype Password" with "staff123"
   When I press "Sign up"
   When I follow "Manage Users"
   Then I should see "Manage Check-in Staff"
   Then I should see "stafftest"
   
