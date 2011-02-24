Feature: Gem pages
  In order to interact with the gems for my team
  As a user
  I want to see them

  @javascript
  Scenario: User visits gems page
    Given I am authenticated as a "bootstrapp" member
    And a gem "test-0.0.0.gem" by "bootstrapp"
    When I go to the "bootstrapp" gems page
    Then I should see "test"
