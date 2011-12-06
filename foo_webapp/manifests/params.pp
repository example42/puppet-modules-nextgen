# Class: foo_webapp::params
#
# This class defines default parameters used by the main module class foo_webapp
# Operating Systems differences in names and paths are addressed here 
#
# == Variables
# 
# Refer to foo_webapp class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It may be imported or inherited by other classes
#
class foo_webapp::params {

  # Default installation type depends on OS package availability
  $install = "package"

  # Install source from the upstream provider is updated to module's last update time
  # You may need to change this: use the "install_source" parameter of the foo_webapp class
  $install_source = "http://download.foo_webapp.com/foo_webapp.tar.gz"
 
  $install_destination = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "/var/www",
    /(?i:Suse|OpenSuse)/      => "/srv/www",
    default                   => "/var/www/html",
  }

  $install_precommand  = ""

  $install_postcommand = ""

  $url_check           = ""

  $url_pattern         = "OK"

  $package = $operatingsystem ? {
    default => "foo_webapp",
  }

  $config_dir = $operatingsystem ? {
    default => "/etc/foo_webapp/conf",
  }

  $config_file = $operatingsystem ? {
    default => "/etc/foo_webapp/foo_webapp.conf",
  } 

  $config_file_mode = $operatingsystem ? { 
    default => "0644",
  }

  $config_file_owner = $operatingsystem ? {
    default => "root",
  }

  $config_file_group = $operatingsystem ? {
    default => "root",
  }

  $data_dir = $operatingsystem ? {
    default => "/var/lib/foo_webapp",
  }

  $log_dir = $operatingsystem ? {
    default => "/var/log",
  }

  $log_file = $operatingsystem ? {
    default => "/var/log/foo_webapp.log",
  }

}
