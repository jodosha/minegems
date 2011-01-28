Feature: Gem
  In order to share code with my team
  As a user
  I want create a new gem

  Scenario: Create gem
    When I create a new gem "test-0.0.0.gem"
    Then a gem "test" should exist
    And a version "0.0.0" should exist for "test" gem
  
  
  
  
