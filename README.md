# Example42 Puppet Modules 2.0 : NextGen

Released under the terms of Apache2 licence.

Copyright Alessandro Franceschi / Lab42 (and specific commits authors)

Official website: [http://www.example42.com](http://www.example42.com)

Official Support forum: [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules)


This repository collects all the Next-gen [Example42](http://www.example42.com) Puppet modules, included here as **git submodules**.

The **official repository** of Example42 Puppet modules on [GitHub](http://github.com/example42/puppet-modules) currently contains both old and next-gen modules for a transitional period that should last until all the modules are migrated.
Old and new modules can cohexist on the same setup, but new modules have different usage patterns and are generally recommended.

## INSTALLATION AND UPDATES

From September 2013 most of the modules are published, and regularly updated, on the **Puppet Forge**.

Use the Puppet module tool to query and install Example42 modules:

        puppet module search example42

You can get the Next-gen only module set with:

        git clone --recursive https://github.com/example42/puppet-modules-nextgen.git

To update your local copy with the upstream version:

        cd /etc/puppet/modules # Or the directory where's you local copy
        git pull origin master
        git submodule init
        git submodule update

If you want to force an update on each submodule, even if not tracked on the main repo:

        git submodule foreach git pull origin master

The above commands (excluded the first cd and included the last) are done by the script:

        Example42-tools/sync.sh

At times you may need to resync git modules urls. You can do that with:

        git submodule sync


You can test these modules on a safe environment using the [Example42 Puppet Playground](https://github.com/example42/puppet-playground). Check it out!

## FEATURES

The main features of Example42 Puppet modules (second generation):

* **Coherent** and standardized structure, logic and usage based on best practices

* **Cross OS support** (main targets are Redhat and Ubuntu derivatives)

* Use of **parametrized classes** and fully qualified variables for Puppet 3 compliance

* **Full API exposure** and classes introspection

* Separation between core module and user's customizations, **no arbitrary logic** enforced.

* Optional **Puppi support** for application deployments and "Puppet knowledge to the CLI"

* Optional **automatic Monitoring** support based on an extensible set of tools

* Optional **automatic Firewalling** support

* **Decommissiong** support: you can remove (almost) whatever you've added

* Complete documentation compliant with **PuppetDoc**

* Integrated **rspec-puppet** tests. Code **puppet-lint** compliant (as much as possible)

* Based on common "foo" templates for **easy scaffolding** on the modules.

## DOCUMENTATION AND SUPPORT

You can find more documentation in the [Example42-documentation](https://github.com/example42/Example42-documentation) directory.

Some Usage examples are in the [example42](https://github.com/example42/example42) module.

A presentation about the features of NextGen modules: [Puppet Modules: A Holistic approach](http://www.slideshare.net/Alvagante/puppet-modules-a-holistic-approach-geneva).

An introductory Blog Post: [The next generation of Example42 Puppet modules](http://example42.com/?q=NextGen).

The official Support forum is on [Google Groups](https://groups.google.com/forum/#!forum/example42-puppet-modules) use it for questions and discussions.


## SPECIAL MODULES 

Generally there's a module for each application and each module is a separated git submodule than can be indipendently retrieved from GitHub.
There are some special modules or directories with different functions:

* `Example42-tools/` contains scripts useful for maintenance of the modules. No Puppet code there.

* `Example42-documentation/` contains documentation about Example42 Puppet modules and their usage.

* `Example42-tutorials/` contains Puppet the markdown code for Puppet Tutorials slides.

* `Example42-templates/` contains various differnet templates for modules' layout. The ones with the 42 suffix are used as starting scaffold for these modules.

* `example42/` is a sample project/customer/site specific module. It contains files and subclasses specific to the Example42 test lab. Here are supposed to be placed all the customizations, and ideally this module (or the equivalent with your company name) is one of the few parts where to make changes. 

* `puppi/` is an Example42 Puppet module that can be used to automate and simplify the deployment of (web) applications and provides a CLI command that exposes most of the information that Puppet has (and defines) about the system. Puppi is a required dependency for all the Example42 modules because it contains some functions used by them, BUT you are not forced to use it. You just have it among your modules to retrieve (via pluginsync) the common functions.

* `monitor/` is an Example42 "meta-module" used for monitoring abstraction. It contains the definitions to use different monitor tools for a set of common resources

* `firewall/` is an Example42 "meta-module" used for firewalling abstraction.


## OPERATING SYSTEMS SUPPORT

Currently the modules are generally tested on the following Operating systems:

* RedHat / Centos versions 5 and 6

* Scientific Linux version 6

* Debian 6

* Ubuntu 10.04 and 12.04

* OpenSuse 11 and 12

* Suse Enterprise Linux 11


Some of the modules have support for:

* Solaris 11


Most of the modules are expected to work on:

* Amazon Linux

* Fedora

* Mint


If you need support or better testing for specific operating systems and versions the best thing you can do is to provide a usable Vagrant Base box for the [Example42 Puppet Playground](https://github.com/example42/puppet-playground). 

## CONTRIBUTE

**Pull requests** via GitHub are welcomed, please review the general style and logic of the modules in order to submit consistent patches.

Do not keep your fork detached from the upstream version, please!

These modules are intended to be used anywhere **without any modification** of their content: if you have to change them to suit your needs either they have some bugs or missing features or you're using them in the wrong way.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/example42/puppet-modules-nextgen/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

