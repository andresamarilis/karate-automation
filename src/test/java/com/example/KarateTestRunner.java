package com.example;

import com.intuit.karate.junit5.Karate;

public class KarateTestRunner {

    @Karate.Test
    Karate runSpecificTests() {
        return Karate.run("classpath:features/simpleTest.feature", "classpath:features/createPostTest.feature", "classpath:features/multiEndpointTest.feature", "classpath:features/UserWorkflowIntegrationTest.feature" );
        // return Karate.run("classpath:features/UserWorkflowIntegrationTest.feature");

    }
    
}
