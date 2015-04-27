Feature: Importing cards as a admin, but should show an error as no file will be selected to import

Scenario: Cards bulk import
   Given I am logged in as admin
   When I follow "Students"
   Then I should see the Students page
   Then I should see "Import Students"
   When I press "Import"
