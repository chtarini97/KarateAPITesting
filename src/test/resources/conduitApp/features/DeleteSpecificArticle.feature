@delspecific
Feature: Deleting articles

  Background:
    * url baseUrl

  Scenario Outline: : Deleting a specific article
    Given path 'articles/', '<articleSlug>'
    When method DELETE
    Then status 204

  #-> Checking article list for deleted article
  Given path 'articles/'
  And param limit = 10
  And param offset = 0
  When method GET
  Then status 200
  * def slugs = get response.articles[*].slug
  * karate.log('List of articles', slugs)
  * match slugs !contains <articleSlug>

  #-> Ensure deleted article is not accessible
  Given path 'articles/', '<articleSlug>'
  When method Get
  Then status 404

  Examples:
    | articleSlug          |
    | Hannah-Abbott-28334  |
    | Marcus-Flint-28334   |
