@art
Feature: Creating Articles

  Background:
    * url baseUrl

  Scenario: Creating article after login
    Given path 'articles/'
    And request
    """
    {
      "article": {
        "title": "Testing again2",
        "description": "Learning Karate",
        "body": "It's awesome",
        "tagList": ["karate", "api"]
      }
    }
    """
    When method Post
    Then status 201
    * karate.set('articleSlug', response.article.slug.toLowerCase())
    * print response.article.slug.toLowerCase()
    And match response.article.title contains 'Testing again'

  Scenario: Checking articles list for newly created article
    Given path '/articles'
    And params {limit:10, offset:0}
    When method GET
    Then status 200
    And match response.articles[0].slug == 'Testing-again2-28334'


