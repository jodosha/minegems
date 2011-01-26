Feature: Gem upload
  In order to make gems available to my team
  As a user
  I want to upload my gems

  Scenario: User upload a new gem
    Given I am on the new gem page
    When I attach "test-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"