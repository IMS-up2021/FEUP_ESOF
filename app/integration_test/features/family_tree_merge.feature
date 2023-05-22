Feature: Login/logout functionality

  Scenario: Login/logout functionality
    Given I am a user of the genealogy app
    When I try to log in to my account with my correct username and password
    Then the app should grant me access to my account
    And when I log out of my account
    Then the app should securely log me out and protect my personal information