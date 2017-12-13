# Packaging Sample Node Applications with Habitat

### Table of contents
* [Introduction](#introduction)
* [Add Habitat to a Sample Application](#add-habitat-to-a-sample-application)
    * [Pre-requisites](#pre-requisites)
    * [Steps](#steps)
* [FAQ](#faq)
* [What's Next?](#whats-next)

## Introduction
This repo contains three examples of adding Habitat to a very basic ‘Hello World’ application.

First, you’ll see how to add Habitat from scratch. Then you’ll see how to simplify the process of adding Habitat by using scaffolding that introspects the application and generates the Habitat plan files for you. The third example will be very similar to the second - both use scaffolding, while the former adds a popular framework to the mix (hint: the scaffolding works the same in both scenarios).

The purpose of this repo is to demonstrate the before and after states. While you are more than welcome to clone this repo and run the steps locally, you can also simply switch between the **start** and **finish** branches to see what the codebase looks like after Habitat is added (i.e. the **finish** branch includes the Habitat plan files for each example).

Lastly, you might also be asking yourself “What are the benefits of packaging my app with Habitat?” If so, check out the [FAQ](#faq) section below.

## Add Habitat to a Sample Application
### Pre-requisites
1. Download and install the Habitat CLI tool
2. Download and install Docker

Instructions and links can be found in the docs under [Installing Habitat](https://www.habitat.sh/docs/using-habitat/#install-habitat)

### Steps
Following are the high-level steps for adding Habitat to a basic application. Simply switch between the `start` and `finish` branches of this repo to see the results of adding Habitat to each example application.

If you choose to perform these steps locally, then you'll need to copy the contents of each file in the `finish` branch.

#### Initialize Habitat
1. `cd` to the application that you want to package (e.g. `cd 01-basic`)
2. Define what’s required by your application
    * **For 01-basic**, you can skip this step
    * **For 02-basic-scaffolding & 03-basic-framework**, add `package.json`
    * Standard for many node applications, you will define what your application requirements are in a package.json file. The example applications are simple enough that they don't require a package.json, however the Node scaffolding relies upon the existence of this file.
3. If you haven’t done so previously, run `hab setup`
    * Every habitat artifact belongs to an origin. As part of this step, you will create an origin and an associated key pair that is used for security purposes. Learn more about [Origins](https://www.habitat.sh/tutorials/download/create-origin/) and [Keys](https://www.habitat.sh/docs/glossary/#glossary-keys) in the docs.
4. Generate a Habitat plan
    * **For 01-basic**, `hab plan init`
    * **For 02-basic-scaffolding & 03-basic-framework**, `hab plan init -s node`
    * The plan is the key component to adding Habitat to your application. It consists of a plan.sh as well as a few configuration and hook files that are described below. Learn more about [writing plans](https://www.habitat.sh/docs/developing-packages/#write-plans) in the docs.
    * When using scaffolding, much of the configuration is done for you. Learn more about [scaffolding](https://www.habitat.sh/docs/glossary/#glossary-scaffolding) in the docs.

#### Configure the applicaiton
1. Edit the origin name in `plan.sh`
    * Much of what Habitat needs to package and run your application is defined in the plan file. For starters, you’ll need to replace the default origin with the one you created during hab setup. Note the difference in the plan.sh files between the example apps (hint: scaffolding greatly simplifies things).
2. Template your configuration settings
    * Add `config/config.json` and edit `default.toml`
    * Reference your new `config.json` file in `app.js`
    * By templating your configuration settings, you’ll be empowered to leverage the Habitat Supervisor for things such as runtime configuration. Learn more about the [Habitat Supervisor features](https://www.habitat.sh/docs/using-habitat/#using-packages) in the docs.
3. Tell the Habitat Supervisor how to start and run the application
    * **For 01-basic**, add the `hooks/init` and `hooks/run` files
    * **For 02-basic-scaffolding & 03-basic-framework**, scaffolding handles this for you
    * Hooks are extra sets of instructions for Habitat to set up and run your app. While scaffolding hides the hooks it generates, you can simply add additional hook files under `/hooks`, as needed. That said, only the **01-basic** `/habitat/hooks` directory contains these files on the _finish_ branch. Learn more about [hooks](https://www.habitat.sh/docs/reference/#reference-hooks) in the docs.

#### Build, export, and run the application
1. Add `docker-compose.yml`
    * While Habitat applications can be run with no additional tooling, we’ve added a sample `docker-compose.yml` to this repo in order to demonstrate a familiar and simple way to run the sample application locally.
2. Enter the clean studio and build your package
    * `hab studio enter` then `build`
    * The Habitat Studio is a clean, self-contained, minimal environment in which you can develop, build, and package software that is free from any upstream operating system distribution. Learn more about the [Habitat Studio](https://www.habitat.sh/docs/habitat-cli/#hab-studio) in the docs.
    * The `build` command generates a `.hart` file that gets stored in the `/results` directory.
3. Export the `.hart` to a Docker image
    * e.g. `hab pkg export docker yourorigin/01-basic`
    * Again optional, packages can be exported into multiple external, immutable runtime formats. Sticking with our Docker approach to this example, we've now exported our application into a container image with a single command. Learn more about [exporting packages](https://www.habitat.sh/docs/developing-packages/#pkg-exports) in the docs.
4. Run the application
    * `exit` the studio. Upon exiting, everything will be removed; however, the results of your build (.hart) will remain available in your current directory.
    * Start the application by running `docker-compose up` or `docker run -it -p 8080:8080 yourorigin/01-basic` then preview it in your browser at <a target="_blank" href="http://localhost:8080">http:localhost:8080</a>
    * Habitat packages do not require the use of Docker to be run. Here we've simply demonstrated how easy it is to export an artifact to the format of your choice. By using Docker here, we have demonstrated the power of Habitat being platform agnostic.

## FAQ
**_What is Habitat and what can it do for me?_**

Habitat consists of three core components:
1. a packaging system
2. a build system and
3. a process supervisor.

With a single download, you’ll be able to automate your workflow and ship your applications with everything they need to run and be managed. Whether it's to bring consistency to how you build and deploy your applications, to gain more control over your application in production, or to move your applications to a cloud-native state, Habitat has you covered.

Habitat is language and platform agnostic which means you can use it to build, deploy, and manage all of your applications, both new and old, in a consistent manner.

**_Do I have to use all three components?_**

No, you can choose to use only what you need and add more capabilities as you get more comfortable. For example, you might have Jenkins build your Habitat artifact (.hart) and deploy it using your existing CI/CD workflow, then use the Habitat supervisor to manage your application. Alternatively, you could replace your current workflow and use the Habitat Build Service to create and promote new builds that are automatically picked up by the Supervisor.

You can also defer making platform decisions until a later date. Start packaging your applications today and choose a platform service later (e.g. export to Docker images), it’s up to you.

**_How do I add Habitat to an application?_**

That’s precisely what the sample apps in this repo will demonstrate!
Essentially, you’ll add a Habitat Plan which consists of a few files - a plan.sh along with a some configuration and hook files. There are a couple of ways to do this (with and without scaffolding) that you’ll see in these examples.

## What's next?
Now that you’re a bit more familiar with the basics, you can turn your attention to some more in-depth materials:

- [Join us on Slack and get answers to your questions](http://slack.habitat.sh/)
- [View the Habitat project on GitHub](https://github.com/habitat-sh/)
- [Try the hands-on Build Service demo](https://habitat.sh/demo)
- [Complete the Habitat Tutorials](https://habitat.sh/tutorials)
- [Browse the Docs for further technical details](https://habitat.sh/docs)
- [Return to the habitat.sh website](https://habitat.sh)
