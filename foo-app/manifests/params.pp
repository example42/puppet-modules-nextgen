# Class: foo-app::params
#
# This class defines default parameters used by the main module class foo-app
# Operating Systems differences in names and paths are addressed here 
#
# == Variables
# 
# Refer to foo-app class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It may be imported or inherited by other classes
#
class foo-app::params {

  $install = "package"

  $install_source = "http://download.foo-app.com/foo-app.tar.gz"
 
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
    default => "foo-app",
  }

  $config_dir = $operatingsystem ? {
    default => "/etc/foo-app",
  }

  $config_file = $operatingsystem ? {
    default => "/etc/foo-app/foo-app.conf",
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
    default => "/var/lib/foo-app",
  }

  $log_dir = $operatingsystem ? {
    default => "/var/log",
  }

  $log_file = $operatingsystem ? {
    default => "/var/log/foo-app.log",
  }

}
