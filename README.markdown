# Example42 Puppet Modules 2.0 : The Next Generation

The new generation of Example42 Puppet modules ( http://www.example42.com ),
compatible only with Puppet 2.6 and later versions.

The current set (1.0) of Puppet modules ( http://github.com/example42/puppet-modules )
generally compatible also with older Puppet versions is going to be mantained only
for bug fixing.

Most of the modules here are defined as git submodules so remember to type:

        git submodule update

to update all the included modules.


## FEATURES

The main features of Example42 Puppet modules (second generation):

* Coherent and standardized structure, logic and usage based on best practices

* Cross OS support (main targets are Redhat and Ubuntu derivatives)

* Use of parametrized classes and fully qualified variables for Puppet 2.8 compliance

* Full and coherent API exposure and classes introspection

* Separation between core module and user's customizations, no arbitrary logic enforced.

* Optional Puppi support for application deployments and "Puppet knowledge to the CLI"

* Optional automatic Monitoring support based on an extensible set of tools

* Optional automatic Firewalling support

* Decommissiong support: you can remove (almost) whatever you've added

* Complete documentation compliant with PuppetDoc

* Based on common "foo" templates for easy scaffolding on the modules.


## SPECIAL MODULES 

Generally there's a module for each application and each module is a separated git submodule than can be indipendently retrived from GitHub.
There are some special modules or directories with different functions:

* 00_example42scripts/ is actually not a module. It contains scripts useful for maintenance of the modules. No Puppet code there.

* example42/ is a sample project/customer/site specific module. It contains files and subclasses specific to the Example42 test lab. Here are supposed to be placed all the customizations, and ideally this module (or the equivalent with your company name) is one of the few parts where to make changes. 

* role/ is a sample module where are defined sample roles that use the other modules and classes. It can be used as reference on how to use the Example42 (next-gen) modules. This is a module open to customizations.

* foo/ and foo_webapp/ are two template modules that are used for scaffolding new modules (that then are customized and enriched according to the specific application)

* stdlib/ is PuppetLabs standard set of libraries. A collection of useful resources and functions that are used in the Example42 modules. This is a required prerequite for all the modules.

* stdlib42/ is a set of fuctions and resources specific to Example42 modules. Also this module is a common prerequisite.

* puppi/ is an Example42 Puppet module that can be used to automate and simplify the deployment of (web) applications and provides a CLI command that exposes most of the information that Puppet has (and defines) about the system 

* monitor/ is an Example42 "meta-module" used for monitoring abstraction. It contains the definitions to use different monitor tools for a set of common resources

* firewall/ is an Example42 "meta-module" used for firewalling abstraction.


## WARNING - PRELIMINARY WORK

This is an ongoing work in progress at very early stages.
Modules are not yet tested in production or in some cases even in a testing environment.

Some modules (puppi, monitor, firewall... ) have been included from the 1.0 modules set
but are going to be largely modified possibly keeping their interfaces.

