Feature: Paginating Pages
  In order to better understand the presented information
  As a user
  I want to view the information in a paginated form
  
  Background:
    Given I go to the pagination page
  
  Scenario: All the links are rendered
     Then I should see "Child 1 (one)"
      And I should see "Child 2 (two)"
      And I should see "Previous"
      And I should see "Next"

  Scenario: Navigating forward and backward
    Given I follow "Next"
     Then I should see "Child 3 (three)"
      And I should see "Child 4 (four)"
     When I follow "Previous"
     Then I should see "Child 1 (one)"
      And I should see "Child 2 (two)"
      
  Scenario: Navigation directly to a page
     When I follow "3"
     Then I should see "Child 5 (five)"
      And I should see "Child 6 (six)"
      