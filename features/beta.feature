Feature: Beta
  In order to be added to the private beta list
  As a user
  I want get my registration code

  Scenario: User requires registration code
    Given I am on the homepage
    When I fill in "email" with "user@example.com"
    And I press "Keep me informed"
    Then I should see "Thanks for being interested in Mine Gems™, you will be contacted soon."

  Scenario: User requires registration code with missing email
    Given I am on the homepage
    And I press "Keep me informed"
    Then I should see "We need an email address to keep in touch with you."

  Scenario: User requires registration code with malformed email
    Given I am on the homepage
    When I fill in "email" with "email address"
    And I press "Keep me informed"
    Then I should see "We need a valid email address to keep in touch with you."

  Scenario: User requires registration code with already taken email
    Given I am on the homepage
    And an early bird registered with "user@example.com/abcdef"
    When I fill in "email" with "user@example.com"
    And I press "Keep me informed"
    Then I should see "Sorry, but you have already subscribed with this email address."

  Scenario: User receives registration code via mail
    Given an early bird registered with "user@example.com/abcdef"
    When I send the registration code for "user@example.com"
    Then I should receive an email at "user@example.com"