# Puppet module: firewall

This is a Puppet abstraction module to manage firewalling.

Made by Alessandro Franceschi / Lab42 - http://www.example42.com

Released under the terms of Apache 2 License.

Check Modulefile for dependencies.

## Goal of this module
This module abstracts the firewalling definitions for an host or application, in order to add and use different firewalling methods, without changes on the single application modules. It provides:
- a common interface for different firewalling tools (currently only local host based iptables)
- an unified syntax for firewalling resources able to adapt to firewalling modules from different authors
- a standard way to define what an application or an host needs to be firewalled
- reversable actions (you can remove a firewall resource previously defined)

## Usage
In order to activate automatic firewalling for the port(s) opened by the service(s) provided by a module you have to pass, at least, these parameters:

        class { "foo":
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }

where firewall_tool is a string or an array of the firewalling tools you want to activate (curretly is supposed only local iptables firewalling with Example42's iptables module). $firewall_src is the source ip address / netmask (may be 0.0.0.0/0) to allow access, and $firewall_dst is the destination address (may be a facter variable.

## Dependencies
This is a meta-module that needs dependencies according to the firewall tools modules you use.
It also requires PuppetLabs' stdlib and Example42's stdlib42 common modules.

## Status of the module
This module is derived from the firewall module of the first generation of Example42 Puppet modules.

Work and adaptation for the second generation of Example42 Puppet module is in progress, some features may be added or modified.

