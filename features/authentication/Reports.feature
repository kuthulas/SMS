Feature: Download Reports as a admin

Scenario: Download Reports
   Given I am logged in as admin
   When I follow "Reports"
   Then I should see "Listing Checkins"
   Then I should see "Download"
   When I follow "Download"
   
