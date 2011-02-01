Feature: Gem upload
  In order to make gems available to my team
  As a user
  I want to upload my gems

  Scenario: User upload a new gem
    Given I am authenticated as a "bootstrapp" member
    Given I am on the new gem page
    When I attach "test-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"

  Scenario: Anonymous user upload a new gem
    When I go to the new gem page
    Then I should be redirected to the sign in page path

  Scenario: User upload an invalid gem
    Given I am authenticated as a "bootstrapp" member
    Given I am on the new gem page
    When I attach "invalid-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "There was errors preventing this gem being registered"

  Scenario: User upgrade an existing gem
    Given I am authenticated as a "bootstrapp" member
    Given a gem "test-0.0.0.gem"
    Given I am on the new gem page
    When I attach "test-0.0.1.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"
    Then an unique "test" gem should exist
    And a version "0.0.1" should exist for "test" gem
