# Right Nurse Tech Test

## Contents
* [Task](#Task)
* [My Approach](#MyApproach)
* [Installation](#Installation)
* [RSpec Tests](#RSpecTests)

## <a name="Task">Task</a>:

Thanks for taking the time to attempt the Right Nurse tech test!

We have tried to design a test that reflects the kind of work we are doing at Right Nurse. Although the test is simplistic, it requires the same skills as our real day-to-day work.

The test is not timed but we recommend that you spend no more than 3 hours on it.

## Requirements

Your task is build API endpoints for a nurse resource.

Your endpoints should allow the client to perform the following:
* View all nurses in the system
* View a single nurse object
* Create a single nurse object
* Update a single nurse object
* Delete a single nurse object

Your endpoints should include **all** the fields on the nurse table.

`verified` and `sign_in_count` fields should not be updatable via the API.

## Additional Notes

The initial Rails application has already been built. Along with some database tables and models. You shouldn't need to modify the database or models.

If you are invited to a face-to-face interview, you will be required to explain your code.

## <a name="MyApproach">My Approach</a>:

The first thing I did when opening the project folder was to run rspec to check whether there were any tests. Having seen that there were no tests written yet, I proceeded by installing the rspec gem along with database cleaner to keep the test database clean.

Secondly, I moved on to have a look at the database's schema and at the models. I then had a general look at the application and added a .gitignore file to ignore logs and temporary files which are not needed.

Next thing: creating tests. I started by writing down tests for the 'create' action. I saw my tests going from red to green, making them pass in a TDD fashion. I carried on with the 'update' and 'delete' actions, to finish off with the viewing actions. When appropriate, I added contexts to deal with edge cases. Last but not least, I refactored my tests to make them more DRY.

Thank you.

Technologies used: Ruby, RSpec.

## <a name="Installation">Installation</a>
* To clone the repository:
```shell
$ git clone https://github.com/enonnai/right_nurse_backend_tech_test
$ cd right_nurse_backend_tech_test
$ bundle
```

## <a name="RSpecTests">RSpec Tests</a>
* To run the tests:
```shell
$ cd right_nurse_backend_tech_test
$ bundle exec rspec
```
