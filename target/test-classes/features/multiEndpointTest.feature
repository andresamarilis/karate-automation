Feature: API Tests with Multiple Endpoints

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Get a list of users and validate the response
    Given path 'users'
    When method GET
    Then status 200
    And match response == '#[]'
    # Ensures response is an array
    And match response[0].id == 1
    And match response[0].username == 'Bret'

  Scenario: Create a new post for a specific user and validate the response
    Given path 'posts'
    And request { userId: 1, title: 'My New Post', body: 'This is content for the new post.' }
    When method POST
    Then status 201
    And match response.userId == 1
    And match response.title == 'My New Post'
    And match response.body == 'This is content for the new post.'
    And match response.id == '#number'

  Scenario: Retrieve comments for a specific post and validate details
    Given path 'posts', 1, 'comments'
    When method GET
    Then status 200
    And match response == '#[]'
    # Ensures it's an array of comments
    And match response[0].postId == 1
    And match response[0].email contains '@'

  Scenario: Update an existing post and validate the response
    Given path 'posts', 1
    And request { title: 'Updated Title' }
    When method PATCH
    Then status 200
    And match response.title == 'Updated Title'
    And match response.userId == 1
    And match response.id == 1

  Scenario: Delete a post and verify response
    Given path 'posts', 1
    When method DELETE
    Then status 200
    # Validate that DELETE is acknowledged with a 200, but no deletion persists on this API

    # Optional check to confirm post still exists, as JSONPlaceholder does not persist deletions
    Given path 'posts', 1
    When method GET
    Then status 200
    And match response.id == 1
    And match response.userId == 1
    And match response.title == 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit'
