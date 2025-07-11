
Feature: Test for HomePage

  Background:
    * url baseUrl

  Scenario: Get all tags
    Given path 'tags'
    When method GET
    Then status 200
    #* print response
    * karate.log('Response:', response)
    And match response.tags contains ['YouTube', 'Blog']
    And match response.tags !contains 'QA Skills'
    And match response.tags contains any ['Test','fish']
    #-> contains only checks that the response has only these values and nothing else
    #And match response.tags contains only
    #-> matching return type of response
    And match response.tags == "#array"
    #-> matching return type of each value in the response
    And match each response.tags == "#string"

  @tags
  Scenario: Get 10 articles
    * def timeValidator = read ('classpath:conduitApp/com/helpers/timeValidator.js')

    Given path 'articles'
    #And param limit = 10
    #And param offset = 0
    And params { limit:10, offset:0 }
    When method GET
    Then status 200
    #-> log prints in the report
    * karate.log('Response:', response)
    And match response == {"articles" : "#array", "articlesCount": 20}
    And match each response.articles ==
    """
    {
            "slug": "#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": ##string,
                "image": "#string",
                "following": "#boolean"
            }
        }
    """
    #And match response.articlesCount == 20
    #-> matching arraylenght of response (array size of 10)
    #And match response.articles == "#[10]"
    #And match response.articles[9].createdAt contains "2025"
    #And match each response.articles[*].author.bio == null
    #And match each response..bio == null
    #And match each response..following == "#boolean"
