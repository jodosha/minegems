Feature: Gem upload
  In order to make gems available to my team
  As a user
  I want to upload my gems

  @javascript
  Scenario: User upload a new gem
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" new gem page
    When I attach "test-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"
    And "test/0.0.0" gem should exist for "bootstrapp"

  @javascript
  Scenario: User upload a pre-release gem
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" new gem page
    When I attach "test-0.0.1.beta1.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"
    And "test/0.0.1.beta1" gem prerelease should exist for "bootstrapp"

  Scenario: Anonymous user upload a new gem
    When I go to the "bootstrapp" new gem page
    Then I should be redirected to the sign in page path

  @javascript
  Scenario: User upgrade an existing gem
    Given I am authenticated as a "bootstrapp" member
    And a gem "test-0.0.0.gem" by "bootstrapp"
    And I am on the "bootstrapp" new gem page
    When I attach "test-0.0.1.gem"
    And I press "Upload gem"
    Then I should see "Gem was successful registered"
    And "test/0.0.1" gem should exist for "bootstrapp"

  @javascript
  Scenario: User upload an invalid gem
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" new gem page
    When I attach "invalid-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "There was errors preventing this gem being registered"

  @javascript
  Scenario: User upload an non-gem file
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" new gem page
    When I attach "gem.jpeg"
    And I press "Upload gem"
    Then I should see "There was errors preventing this gem being registered"

  @javascript
  Scenario: User upload gem with already taken name
    Given a gem "test-0.0.0.gem" by "acme"
    And I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" new gem page
    When I attach "test-0.0.0.gem"
    And I press "Upload gem"
    Then I should see "There was errors preventing this gem being registered"
    And "test/0.0.0" gem should not exist for "bootstrapp"
