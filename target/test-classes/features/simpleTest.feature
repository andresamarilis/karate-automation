Feature: Sample API Test with Assertions

  Scenario: Validate GET request to fetch all posts
    Given url 'https://jsonplaceholder.typicode.com/posts'
    When method GET
    Then status 200
    And match response[0].userId == 1
    And match response[0].id == 1
    And match response[0].title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
