Feature: New Checkin as a admin

Scenario: New Checkin
   Given I am logged in as admin
   When I follow "Reports"
   Then I should see "Listing Checkins"
   Then I should see "New Checkin"
   When I follow "New Checkin"
   Then I should see "New Checkin"
