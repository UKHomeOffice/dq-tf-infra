# DQ Terraform Infra.

[![Build Status](https://drone.digital.homeoffice.gov.uk/api/badges/UKHomeOffice/dq-tf-infra/status.svg)](https://drone.digital.homeoffice.gov.uk/UKHomeOffice/dq-tf-infra)

This module describes the overarching architecture of the modules in the DQ AWS environments.

It can be run against both Production and non-Production environments by setting a variable at runtime to switch the provider used.

## Content overview

This repo controls the deployment of all the sub-modules.

It consists of the following core elements:

### main.tf

Describe providers in use and terraform backend location.

### data.tf

Data resource to extract values across modules.

### ad.tf

Controls resources in the AD VPC.

### apps.tf

Controls resources in the Apps VPC.

### ops.tf

Controls resources in the Ops VPC.

### peering.tf

Controls resources in the Peering VPC.

### vpcpeering,tf

Sets up inter and intra VPC peering.

### variable.tf

Input data for resources within this repo.

## User guide

### Prepare your local environment

This project currently depends on:

* drone v0.5+dev
* terraform v0.11.1+
* terragrunt v0.13.21+
* python v3.6.3+

Please ensure that you have the correct versions installed (it is not currently tested against the latest version of Drone)

### How to run/deploy

To run tests using the [tf testsuite](https://github.com/UKHomeOffice/dq-tf-testsuite):
```shell
drone exec --repo.trusted
```
To launch:
```shell
terragrunt plan
terragrunt apply
```

## FAQs

### The remote state isn't updating, what do I do?

If the CI process appears to be stuck with a stale `tf state` then run the following command to force a refresh:

```
terragrunt refresh
```
If the CI process is still failing after a refresh look for errors about items no longer available in AWS - say something that was deleted manually via the AWS console or CLI.
To explicitly delete the stale resource from TF state use the following command below. *Note:*```terragrunt state rm``` will not delete the resource from AWS it will unlink it from state only.

```shell
terragrunt state rm aws_resource_name
```
