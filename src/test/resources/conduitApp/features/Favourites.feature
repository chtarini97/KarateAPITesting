@favorites
Feature: Favorited articles

  Background:
    * url baseUrl
    * def timeValidation = read('classpath:conduitApp/helpers/timeValidator.js')

  Scenario: Favoriting most recently created article
    # Step 1: Get articles of the global feed
    # Step 2: Get the favorites count and slug ID for the first article, save it to variables
    # Step 3: Make POST request to favorite the first article
    # Step 4: Verify response schema
    # Step 5: Verify that favorites article incremented by 1
    # Step 6: Get all favorite articles
    # Step 7: Verify response schema
    # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    # Step 9: Make DELETE request to remove favorite from the first article
    # Step 10: Verify response schema
    # Step 11: Verify that favorites article decremented by 1

    #-> Get the favorites count and slug ID for the first article, save it to variables
    Given path 'articles'
    And params {limit: 10, offset: 0}
    When method GET
    Then status 200
    * def firstSlug = response.articles[0].slug
    * print firstSlug
    * def favoriteCount = response.articles[0].favoritesCount
    And match favoriteCount ==  0
    #-> Verify response schema
    And match response.articles[0] ==
    """
    {
      "slug": "#string",
      "title": "#string",
      "description": "#string",
      "body": "#string",
      "tagList": #array,
      "createdAt": "#? timeValidation(_)",
      "updatedAt": "#? timeValidation(_)",
      "favorited": "#boolean",
      "favoritesCount": "#number",
      "author": {
          "username": "#string",
          "bio": "##string",
          "image": "#string",
          "following": "#boolean"
      }
    }
    """

    #-> Get all favorite articles before liking new article
    Given path 'articles/'
    And param favorited = userName
    And param limit = 10
    And param offset = 0
    When method GET
    Then status 200
    * def favArticlesCount = response.articlesCount
    * print favArticlesCount

    #-> Make POST request to favorite the first article
    Given path 'articles/' + firstSlug + '/favorite'
    And header Content-Length = 0
    When method POST
    Then status 200
    And match response.article.slug contains firstSlug
    And match response.article.favoritesCount == 1
    And match response.article.favorited == true
    And match response.article.favoritedBy[0].id == 28334

    #-> getting all the favorited articles after adding new favortie
    Given path 'articles/'
    And param favorited = userName
    And param limit = 10
    And param offset = 0
    When method GET
    Then status 200
    * print favArticlesCount
    #-> Verify that favorites article incremented by 1
    And match response.articlesCount == favArticlesCount + 1
    #-> Verify that slug ID from Step 2 exist in one of the favorite articles
    And match response.articles[*].slug contains firstSlug

    #-> Make DELETE request to remove favorite from the first article
    Given path 'articles/' + firstSlug + '/favorite'
    When method DELETE
    Then status 200
    And match response.article.slug contains firstSlug
    And match response.article.favoritesCount == 0
    And match response.article.favorited == false
    #-> checking array length = 0
    And match response.article.favoritedBy == '#[0]'

    #-> getting all the favorited articles after removing the like
    Given path 'articles/'
    And param favorited = userName
    And param limit = 10
    And param offset = 0
    When method GET
    Then status 200
    * print favArticlesCount
    #-> Verify that favorites article decremented by 1
    * print response.articlesCount
    And match response.articlesCount == favArticlesCount
    #-> Verify that slug ID from Step 2 does not exist in one of the favorite articles
    And match response.articles[*].slug !contains firstSlug


