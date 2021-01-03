# Data Durability and Recovery

This repo is a submission for Udacity AWS Cloud Architect, Data Durability and Recovery project. The original starter template of this project can be found in the following [link](https://github.com/udacity/nd063-c2-design-for-availability-resilience-reliability-replacement-project-starter-template).

## Terraform

The original project is created using cloudformation. Due to my interest to learn terraform I decided to do the project (including recreating the cloudformation template) using terraform. All terraform files are stored under `/terraform` folder.

The project required you to provisioned aws resources in two different regions (primary & secondary) hence the terraform files are structured based on their region as follows:

```bash
terraform
|___ primary
|   |
|   |___ main.tf
|   |___ db.tf
|   |...
|
|___ secondary
|   |
|   |___ main.tf
|   |___ db.tf
|   |...
```

## Getting Started

To get started, you could read the original readme guide provided by the upstream repo [here](https://github.com/abiwinanda/nd063-c2-design-for-availability-resilience-reliability-replacement-project/blob/master/GETTING_STARTED.md).

## Screenshots

All screenshots of the project's tasks are stored under `/screenshots` folder. The screenshots are divided into each part as follows:

```bash
screenshots
|___ part-1
|   |___ screenshots.png
|
|___ part-2
|   |___ screenshots.png
|
|___ part-3
    |___ screenshots.png
```
