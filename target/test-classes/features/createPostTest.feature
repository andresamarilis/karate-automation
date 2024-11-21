Feature: API Test for Creating a New Post

  Scenario: Validate POST request to create a new post
    Given url 'https://jsonplaceholder.typicode.com/posts'
    And request { userId: 1, title: 'New Post', body: 'This is a new post content' }
    When method POST
    Then status 201
    And match response.userId == 1
    And match response.title == 'New Post'
    And match response.body == 'This is a new post content'
    And match response.id == '#number'
