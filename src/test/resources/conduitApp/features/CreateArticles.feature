@art
Feature: Creating Articles

  Background:
    * url baseUrl
    * def articleRequestBody = read('classpath:conduitApp/jsonFiles/newArticleRequest.json')
    * def dataGen = Java.type('conduitApp.utils.DataGenerator')
    * def randomArticleRequest = dataGen.getArticleRequest()
    * set articleRequestBody.article.title = randomArticleRequest.title
    * set articleRequestBody.article.description = randomArticleRequest.description
    * set articleRequestBody.article.body = randomArticleRequest.body
    * set articleRequestBody.article.tagList = randomArticleRequest.tagList

  Scenario: Creating article after login
    Given path 'articles/'
    And request articleRequestBody
    When method Post
    Then status 201
    * karate.set('articleSlug', response.article.slug)
    * print response.article.slug.toLowerCase()
    And match response.article.title == articleRequestBody.article.title

    #-> Checking articles list for newly created article
    Given path '/articles'
    And params {limit:10, offset:0}
    When method GET
    Then status 200
    * def expectedSlug = karate.get('articleSlug')
    And match response.articles[0].slug == expectedSlug


