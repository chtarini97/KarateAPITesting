@del
Feature: Deleting articles

  Background:
    * url baseUrl
    * callonce read('CreateArticles.feature')
    * print ("Recent article Slug: ", articleSlug)

  Scenario: Deleting most recently created article
    Given path '/articles/' + articleSlug
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
    * match slugs !contains articleSlug

  Scenario: Ensure deleted article is not accessible
    Given path '/articles/' + articleSlug
    When method Get
    Then status 404
