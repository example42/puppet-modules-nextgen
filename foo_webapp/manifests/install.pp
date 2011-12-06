# Class: foo_webapp::install
#
# This class installs foo_webapp
#
# == Variables
# 
# Refer to foo_webapp class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It's automatically included by foo_webapp
#
class foo_webapp::install inherits foo_webapp {

  case $foo_webapp::install {

    package: {
      package { "foo_webapp":
        name   => "${foo_webapp::package}",
        ensure => "${foo_webapp::manage_package}",
      }
    }

    source: {
      netinstall { "netinstall_foo_webapp":
        url                 => "${foo_webapp::install_source}",
        destination_dir     => "${foo_webapp::install_destination}",
        preextract_command  => "${foo_webapp::install_precommand}",
        postextract_command => "${foo_webapp::install_postcommand}",
      }
    }

    puppi: {
      puppi::project::archive { "foo_webapp":
        source                   => "${foo_webapp::install_source}",
        deploy_root              => "${foo_webapp::install_destination}",
        predeploy_customcommand  => "${foo_webapp::install_precommand}",
        postdeploy_customcommand => "${foo_webapp::install_postcommand}",
        report_email             => "root",
        auto_deploy              => true,
        enable                   => true,
      }
    }

  }

}
