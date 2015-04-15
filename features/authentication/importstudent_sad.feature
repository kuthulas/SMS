Feature: Importing cards as a admin

Scenario: Cards bulk import
   Given I am logged in as admin
   When I follow "Students"
   Then I should see the Students page
   Then I should see "Import Students"
   When I follow "Browse..."
   When I press "Import"
