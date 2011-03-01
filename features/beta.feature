Feature: Beta
  In order to be added to the private beta list
  As a user
  I want get my registration code

  Scenario: User requires registration code
    Given I am on the homepage
    When I fill in "email" with "user@example.com"
    And I press "Keep me informed"
    Then I should see "You will be contacted a soon as possible."