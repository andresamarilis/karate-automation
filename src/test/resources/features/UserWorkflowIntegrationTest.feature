Feature: Simulated Connected Workflow with JSONPlaceholder

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: Workflow with Linked Actions

    # Step 1: Retrieve a user with ID 1
    Given path 'users', 1
    When method GET
    Then status 200
    And match response.id == 1
    And match response.username == 'Bret'
    * def userId = response.id
    # Comment: Fetches an existing user with ID 1 and saves the user ID for future requests.
    # Assertion: Checks that the response ID is 1 and username is 'Bret' to confirm expected data.

    # Step 2: Create a new post (simulated; won't actually persist)
    Given path 'posts'
    And request { userId: '#(userId)', title: 'Sample Post', body: 'Temporary content for testing.' }
    When method POST
    Then status 201
    And match response.userId == userId
    And match response.title == 'Sample Post'
    And match response.body == 'Temporary content for testing.'
    * def postId = 1
    # Comment: Simulates creation of a new post for the retrieved user. 
    # Assertions: Verifies that the response includes the correct user ID, title, and body.
    # Note: Sets postId = 1 for continuity due to JSONPlaceholder’s lack of actual data persistence.

    # Step 3: Retrieve an existing post with ID 1 to simulate getting a newly created post
    Given path 'posts', postId
    When method GET
    Then status 200
    And match response.id == postId
    And match response.userId == userId
    # Comment: Simulates retrieving the previously "created" post by its ID. Skips matching `title` due to API limitations.
    # Assertions: Only checks that the ID and userId are correct since JSONPlaceholder doesn’t retain post changes.

    # Step 4: Update the title of an existing post with ID 1
    Given path 'posts', postId
    And request { title: 'Updated Sample Post' }
    When method PATCH
    Then status 200
    And match response.title == 'Updated Sample Post'
    And match response.userId == userId
    And match response.id == postId
    # Comment: Simulates updating the post’s title to a new value.
    # Assertions: Verifies that the title has been updated while userId and postId remain unchanged.

    # Step 5: "Delete" the post with ID 1
    Given path 'posts', postId
    When method DELETE
    Then status 200
    # Comment: Simulates deleting the post. 
    # Assertion: Checks for a successful 200 response, acknowledging JSONPlaceholder's lack of actual data deletion.

    # Step 6: Attempt to retrieve the post with ID 1 and expect status 200 due to persistence limitation
    Given path 'posts', postId
    When method GET
    Then status 200
    And match response.id == postId
    And match response.userId == userId
    # Comment: In a real API, we would check for a 404 to confirm deletion. Here, we expect 200 since JSONPlaceholder doesn’t persist deletions.
    # Assertions: Checks that the ID and userId are still retrievable, simulating that data was not actually removed.
