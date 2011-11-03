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

* Full API exposure and classes introspection

* Complete separation between core module and user's customizations

* Optional Puppi support for application deployments and "Puppet knowledge to the CLI"

* Optional automatic Monitoring support based on an extensible set of tools

* Optional automatic Firewalling support.


## WARNING - PRELIMINARY WORK

This is an ongoing work in progress at very early stages.
Modules are not yet tested in production or in some cases even in a testing environment.

Some modules (puppi, monitor, firewall... ) have been included from the 1.0 modules set
but are going to be largely modified possibly keeping their interfaces.

