Feature: User login

  Background:
    #* def config = call read('classpath:karate-config.js')
    #* print 'Config loaded:', config
    #* url config.baseUrl
    * url baseUrl

  Scenario: User Login
    Given path 'users/login'
    #-> takes userEmail and userPwd from karate-config
    And request { "user": {"email": "#(userEmail)", "password": "#(userPwd)"}}
    When method Post
    Then status 200
    * def authToken = response.user.token
    #-> karate.set to "set" a variable instead of doing karate return
    #* karate.set('authToken', token)