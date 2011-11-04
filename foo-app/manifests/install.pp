# Class: foo-app::install
#
# This class installs foo-app
#
# == Variables
# 
# Refer to foo-app class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It's automatically included by foo-app
#
class foo-app::install inherits foo-app {

  case $install {

    package: {
      package { "foo-app":
        name   => "${foo-app::package}",
        ensure => "${foo-app::manage_package}",
      }
    }

    source: {
      netinstall { "netinstall_foo-app":
        url                 => "${foo-app::install_source}",
        destination_dir     => "${foo-app::install_destination}",
        preextract_command  => "${foo-app::install_precommand}",
        postextract_command => "${foo-app::install_postcommand}",
      }
    }

    puppi: {
      puppi::project::archive { "foo-app":
        source                   => "${foo-app::install_source}",
        deploy_root              => "${foo-app::install_destination}",
        predeploy_customcommand  => "${foo-app::install_precommand}",
        postdeploy_customcommand => "${foo-app::install_postcommand}",
        report_email             => "root",
        auto_deploy              => "once",
        enable                   => true,
      }
    }
  }
}
