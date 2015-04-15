Feature: Adding a new student as a admin

Scenario: Adding a new student
   Given I am logged in as admin
   When I follow "Students"
   Then I should see the Students page
   When I follow "New Student"
   When I fill in "UIN" with "1234567890"
   When I fill in "First Name" with "New" 
   When I fill in "Last Name" with "Student" 
   When I fill in "Card Number" with "0987654321"
   When I fill in "Email" with "new@student.com"
   And I press "Create Student"
   Then I should see "Student was successfully created"
   
