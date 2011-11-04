# Puppet module: foo_webapp

This module installs the foo_webapp web application.
You need to configure separately the Web or Application Server that is going to host foo_webapp


## USAGE - Basic management
* Install foo_webapp with default settings

        class { "foo_webapp": }

* Disable foo_webapp service.

        class { "foo_webapp":
          disable => true,
        }

* Disable foo_webapp service at boot time, but don't stop if is running.

        class { "foo_webapp":
          disableboot => true,
        }

* Remove foo_webapp package

        class { "foo_webapp":
          absent => true,
        }

* Define foo_webapp installation method: Valid values for install => are "package" (default), "source" and puppi.

        class { "foo_webapp":
          install => "source",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check foo_webapp/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "foo_webapp":
          install             => "source",
          install_source      => "http://deploy.example42.com/foo_webapp/foo_webapp.tar.gz",
          install_destination => "/opt/apps/",
          # install_precommand  => "...",
          # install_postcommand => "...",
          # url_check           => "...",
          # url_pattern         => "...",
        }



## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "foo_webapp":
          source => [ "puppet:///modules/lab42/foo_webapp/foo_webapp.conf-$hostname" , "puppet:///modules/lab42/foo_webapp/foo_webapp.conf" ], 
        }

* Use custom template for main config file 

        class { "foo_webapp":
          template => "example42/foo_webapp/foo_webapp.conf.erb",      
        }

* Define custom options that can be used in a custom template without the
  need to add parameters to the foo_webapp class

        class { "foo_webapp":
          template => "example42/foo_webapp/foo_webapp.conf.erb",    
          options  => {
            'LogLevel' => 'INFO',
            'UsePAM'   => 'yes',
          },
        }

* Automaticallly include a custom subclass

        class { "foo_webapp:"
          my_class => 'lab42::foo_webapp',
        }


## USAGE - Example42 extensions management 
* Activate puppi (reccomended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "foo_webapp": 
          puppi    => true,
        }

* Activate automatic monitoring (reccomended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "foo_webapp":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "foo_webapp":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }


