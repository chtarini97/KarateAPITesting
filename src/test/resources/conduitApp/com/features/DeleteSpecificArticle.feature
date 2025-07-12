@delspecific
Feature: Deleting articles

  Background:
    * url baseUrl

  Scenario: Deleting a specific article
    Given path '/articles/testing-again19-28334'
    When method DELETE
    Then status 204

  Scenario: Checking article list for deleted article
    Given path '/articles'
    And param limit = 10
    And param offset = 0
    When method GET
    Then status 200
    * def slugs = get response.articles[*].slug
    * karate.log('List of articles', slugs)
    * match slugs !contains 'Testing-again19-28334'

  Scenario: Ensure deleted article is not accessible
    Given path '/articles/testing-again19-28334'
    When method Get
    Then status 404
