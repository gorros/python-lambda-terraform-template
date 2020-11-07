# python-lambda-terraform-template

## Terraform
#### Initialize
```shell script
$ cd terraform/
$ terraform init -backend-config=backend.tfvars
```

#### Workspace
```shell script
$ terraform workspace list
```

If workspaces exist, such as `dev`, `stage` or `prod`
```shell script
$ terraform workspace select YOUR_ENV
```

If there is only `default` one, create a new one
```shell script
$ terraform workspace new YOUR_ENV
```

Finally, plan and deploy
```shell script
$ terraform plan -var-file=prod.tfvars
$ terraform apply -var-file=prod.tfvars
```

## CI/CD

We use [Github Actions](https://github.com/features/actions) to run CI/CD workflows. 
To test and deploy Lambdas together with the rest of the infrastructure we need just one workflow with two jobs:
- Test lambdas and make sure that not only all tests are passing but also appropriate test coverage is achieved  
- Plan and apply changes to the infrastructure with Terraform. The main idea is to only run `terraform plan` and present
 future changes if it is a PR and run `terraform apply` only when that PR is approved and merged to `stage` or `master` (`main`) branch.

#### Git
For this setup to work, you should have a corresponding branch for each environment. For example:
- master -> prod
- staging -> stage
- dev -> dev
Here we assume that you have `prod`  and `stage` environments. But similar to those you can also add `dev`. 
The main idea is to map each environment
  to corresponding Terraform workspace described above. 

#### Github Actions Runner
Our CI/CD process assumes that you are using `self-hosted` runner on an EC2. This approach has several benefits in 
comparison to Github-hosted runners. First, this was you are not limited to credits that Github provides and
 usually a `t3.micro` instance should be enough and want cost much or will be free since it is eligible for free tier.
 Second, this approach is more secure. You do not need to save access secrets or other sensitive information in Github
 Secrets. You only need to attach a corresponding role to an EC2 instance which should allow it to assume a more powerful role.
 Self-hosted runner are easy to setup. Just follow these guidelines:
- https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners
- https://docs.github.com/en/actions/hosting-your-own-runners/configuring-the-self-hosted-runner-application-as-a-service

## Lambda

Lambda module has following structure
```
lambda
|-- src
|   `-- lambda.py
|-- tests
|   `-- test_lambda.py
|-- .gitignore
`-- requirements.txt

```

`lambda.py` and `test_lambda.py` are placeholders for actual lambdas and their tests.
