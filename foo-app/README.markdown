# Puppet module: foo-app

This module installs the foo-app web application.
You need to configure separately the Web or Application Server that is going to host foo-app


## USAGE - Basic management
* Install foo-app with default settings

        class { "foo-app": }

* Disable foo-app service.

        class { "foo-app":
          disable => true,
        }

* Disable foo-app service at boot time, but don't stop if is running.

        class { "foo-app":
          disableboot => true,
        }

* Remove foo-app package

        class { "foo-app":
          absent => true,
        }

* Define foo-app installation method: Valid values for install => are "package" (default), "source" and puppi.

        class { "foo-app":
          install => "source",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check foo-app/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "foo-app":
          install             => "source",
          install_source      => "http://deploy.example42.com/foo-app/foo-app.tar.gz",
          install_destination => "/opt/apps/",
          # install_precommand  => "...",
          # install_postcommand => "...",
          # url_check           => "...",
          # url_pattern         => "...",
        }



## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "foo-app":
          source => [ "puppet:///modules/lab42/foo-app/foo-app.conf-$hostname" , "puppet:///modules/lab42/foo-app/foo-app.conf" ], 
        }

* Use custom template for main config file 

        class { "foo-app":
          template => "example42/foo-app/foo-app.conf.erb",      
        }

* Define custom options that can be used in a custom template without the
  need to add parameters to the foo-app class

        class { "foo-app":
          template => "example42/foo-app/foo-app.conf.erb",    
          options  => {
            'LogLevel' => 'INFO',
            'UsePAM'   => 'yes',
          },
        }

* Automaticallly include a custom subclass

        class { "foo-app:"
          my_class => 'lab42::foo-app',
        }


## USAGE - Example42 extensions management 
* Activate puppi (reccomended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "foo-app": 
          puppi    => true,
        }

* Activate automatic monitoring (reccomended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "foo-app":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "foo-app":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }


