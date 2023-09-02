# Terraform Tasks

This repo has several terraform directories with their own `.tf` files. Each of these represents an independent task and should not rely on any infrastructure from each other.

Tasks 1 and 2 have their own dedicated folders and all remaining files and folders make up task 3.
## Task 1

Navigate to the `task1` directory. 

Use Terraform to create an S3 bucket with a name of your choice (remembering it must be unique). You should also ensure that Terraform copies the file `test_file.txt` into the bucket.

The `provider.tf` file is complete, but you will need to complete the resources in `s3.tf`. Use the Terraform documentation to guide you.

Check that it has worked using an AWS CLI command and then using the browser.

## Task 2

Create a Lambda that uses the code in `demo.py`. You do not need to add a trigger.

You will need to supply an IAM role to allow the Lambda to write logs to Cloudwatch. You might be able to use a role or policies that exist already in your sandbox account.

You can check that the Lambda has been created by looking in the browser. You can trigger the Lambda in the console by creating a dummy test event. 

## Task 3 

For this task you are going to re-create the file-reader lambda that we previously created via the CLI. The relevant files are in the root of this repo and are detailed below. 

The `terraform` directory has been pre-populated with some of the infrastructure. Compare what's been done already to what was created last time and use the docs to help you complete the lambda infrastructure.
### Demonstration Project For AWS Infrastructure

The purpose of this project is to demonstrate (in a manner close to production-level code) how to deploy a simple AWS Lambda and associated infrastructure to an AWS account.

Features of the project:
1. A simple lambda handler (`src/file_reader/reader.py`) that accepts an S3 event, checks if it refers to a `txt` file and then logs the contents of the file.
2. The code features trapping of specific errors (including a custom error) and handles unexpected `RuntimeErrors`.
3. The code is tested (`test/test_file_reader/test_lambda.py`) using the `moto` library to mock AWS artefacts. Test coverage for executed code is 86%.
4. The project build is via a `Makefile` which allows `bandit` and `safety` checks for security vulnerabilities, and `flake8` checks for PEP8 compliance.


### Prerequisites for local development
- Python
- Make
- AWS CLI tool (__version 2__) - installation instructions here: [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### __Usage__

1. Fork and clone this project.
2. In the terminal, navigate to the root directory of the project, and run:
    ```bash
    make requirements
    ```
3. Then run:
    ```bash
    make dev-setup
    make run-checks
    ```
 
 ## Day 2 - CI / CD

 Your task is to build a pipeline with Github actions that will automate the deployment of task 3 whenever changes are pushed to the main branch of this repo.

 Your pipelines should:
    - Run the checks defined by the `Makefile` to ensure that the code works as intended and is compliant.
    - If those checks pass then use terraform to make the required changes to the infrastructure.
