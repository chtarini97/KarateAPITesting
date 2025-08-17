# KarateAPITesting

# Overview
Karate API automation suite for the Conduit sample app (CRUD flows). Tests are organized into feature files with Java helpers and a JUnit runner.

# Tech stack
1. Karate for API testing & assertions
2. JUnit runner
3. Java utilities (e.g., encryption, data generation)
4. JavaFaker for random test data
5. karate-config.js for environment config & auth header wiring (token)
 
# Prerequisites
- JDK 17+
- Maven 3.8+
- Git

# Verify:
- java -version
- mvn -version
- git --version

# Setup
Clone
1. git clone https://github.com/chtarini97/KarateAPITesting.git
2. cd KarateAPITesting

# How to run tests
1. Run via JUnit Runner (IDE):
   - Open ConduitTestRunner and:
   - Change the @Karate.Test or Runner.path()/tags() to the feature or tag you want.
   - Right-click → Run.

# Test data
JavaFaker generates random emails/usernames to avoid collisions. 

# Reports
Karate auto-generates: (Open the HTML in a browser after a run) 
- target/karate-reports/karate-summary.html (aggregate)
- target/karate-reports/*/karate*.html (per feature)

