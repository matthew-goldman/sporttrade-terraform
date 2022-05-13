# Public Terraform Demo

It is built to use Terraform > 1.1.9

There are two main directories in this repo:

  - Modules: Where the actual modules that make changes are located
  - Environments: Where the values for deploying territories per environment are located

## Usage

This repo assumes that you have at least terraform-1.1.9 installed. Instructions are here:

  https://learn.hashicorp.com/terraform/getting-started/install.html

It is encouraged to use tfswitch as well.

This repo also assumes that you have AWS authentication configured.

To deploy, `cd` into the "environments" directory. Then:

```bash
$ terraform init
$ terraform workspace select [THING]
$ terraform plan -var-file vars/[THING].tf
$ terraform apply -var-file vars/[THING].tf
```
> TIP: is recommended to execute the plan/apply by using:
`terraform plan -var-file vars/$(terraform workspace show).tf`. This way you avoid to apply changes from a territory
varfile over the wrong territory workspace

The workspace is a feature that Terraform provides for separating the state files of the resources you create when calling plan/apply. It will create a path in the s3 bucket used as backend like:

```
env:/workspace-name/aws/state.tfstate
```

### **REMEMBER** When planning/applying be **sure you are in the right workspace**

## Design

This is designed to be agnostic - modules should have no territory-specific information stored in them. All environment-specific information should be stored in the environment's appropriate directory and then overwrite territories-specific values by defining them in the appropiate vars/ file.

Reducing repetition is also a key design tenant. The goal is to repeat ourselves as little as possible. Unfortunately, terraform does not have a great way to iterate over loops, but it can always be improved and worked on.

## Minimum VPC configs

- Create a new vars file inside of the environment directory you want to use:
```bash
cp -r vars/foo-territory.tf vars/bar-territory.tf
```

- Modify the values with territory-specific info:
  - `territory=`
  - `region=`
  - `aws_region=`
  - `vpc_cidr=`
  - `domain_name=`

- Call terraform this way (after terraform init)
```bash
  terraform plan -var-file=bar-territory.tf
  terraform apply -var-file=bar-territory.tf
```
