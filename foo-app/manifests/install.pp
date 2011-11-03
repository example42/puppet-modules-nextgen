# Class: foo::install
#
# This class installs foo
#
# == Variables
# 
# Refer to foo class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It's automatically included by foo
#
class foo::install inherits foo {

  case $install {

    package: {
      package { "foo":
        name   => "${foo::package}",
        ensure => "${foo::manage_package}",
      }
    }

    source: {
      netinstall { "netinstall_foo":
        url                 => "${foo::install_source}",
        destination_dir     => "${foo::install_destination}",
        preextract_command  => "${foo::install_precommand}",
        postextract_command => "${foo::install_postcommand}",
      }
    }

    puppi: {
      puppi::project::archive { "foo":
        source                   => "${foo::install_source}",
        deploy_root              => "${foo::install_destination}",
        predeploy_customcommand  => "${foo::install_precommand}",
        postdeploy_customcommand => "${foo::install_postcommand}",
        report_email             => "root",
        auto_deploy              => "once",
        enable                   => true,
      }
    }

}
