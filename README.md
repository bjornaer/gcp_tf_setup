# Max's DBRE Toggl Excercise

Hi, thank you for taking the time to go over my excercise!

Some comments are left in the `.tf` files for clarification (I find it's easier to have the comment within the contextof it's corresponding file rather than on the readme)

## Setup

1. You gotta have a GCP project.
2. Now, grab your project's name and id and add them to the [tfvars file in this dir](./terraform.tfvars)
3. Another thing you'll have to do is set the credentials as a JSON in this dir, under the `toggl-tfadmin.json` name.
4. ???
5. Profit

## I want to terraform this
---
![do it](https://media.giphy.com/media/3o84sw9CmwYpAnRRni/giphy.gif)

`terraform plan`
and
`terraform apply`


## I do not have GCP APIs enabled
---
Please [install gcloud](https://cloud.google.com/sdk/docs/install) and set it up, then run [the api enabling script](./enable-gcp-api.sh)