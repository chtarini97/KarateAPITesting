
Feature: New User Sign up

  Background: Preconditions
    * def userData = Java.type('conduitApp.utils.DataGenerator')
    * url baseUrl

  @signup
  Scenario: Sign up new user
    * def randomEmail = userData.getRandomEmail()
    * def randomUsername = userData.getRandomUsername()

    Given path 'users'
    And request
    """
    {
        "user": {
            "email": "#(randomEmail)",
            "password": "#(userPwd)",
            "username": "#(randomUsername)"
          }
    }
    """
    When method Post
    Then status 201
    And match response ==
    """
    {
      "user": {
          "id": "#number",
          "email": "#(randomEmail)",
          "username": "#(randomUsername)",
          "bio": "##string",
          "image": "#string",
          "token": "#string"
      }
    }
    """

  @negative
  Scenario Outline: Validate existing error message
    * def randomEmail = userData.getRandomEmail()
    * def randomUsername = userData.getRandomUsername()

    Given path 'users'
    And request
    """
    {
        "user": {
            "email": "<email>",
            "password": "<pwd>",
            "username": "<username>"
          }
    }
    """
    When method Post
    Then status <errorCode>
    And match response == <errorResponse>

    Examples:
    | email                             | username               | pwd         | errorResponse                                                                                        | errorCode |
    | hermoinegranger@karate.testing    | #(randomUsername)      | #(userPwd)  | {"errors":{"email":["has already been taken"]}}                                                      | 422       |
    | #(randomEmail)                    | hermoinegranger1       | #(userPwd)  | {"errors":{"username":["has already been taken"]}}                                                   | 422       |
    | hermoinegranger1@karate.testing   | hermoinegranger1       | #(userPwd)  | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}}                | 422       |
    | hermoinegranger1@karate.testing   | hermoinegrangerWWWWWWW | #(userPwd)  | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                                   | 422       |
    | hermoinegranger3                  | hermoinegranger3       | #(userPwd)  | {"errors":{"email":["is invalid"]}}                                                                  | 422       |
    |                                   | hermoinegranger4       | #(userPwd)  | {"errors":{"email":["can't be blank"]}}                                                              | 422       |
    | hermoinegranger4@karate.testing   |                        | #(userPwd)  | {"errors":{"username":["can't be blank"]}}                                                           | 422       |
    |                                   |                        | #(userPwd)  | {"errors":{"email":["can't be blank"],"username":["can't be blank"]}}                                | 422       |
    | hermoinegranger4@karate.testing   | hermoinegranger4       |             | {"errors":{"password":["can't be blank"]}}                                                           | 422       |
    | ##(null)                          | ##(null)               |  ##(null)   | {"errors":{"email":["can't be blank"],"username":["can't be blank"],"password":["can't be blank"]}}  | 422       |
    | null                              | null                   | null        | {"errors":{"email":["is invalid"],"password":["is too short (minimum is 8 characters)"]}}            | 422       |

