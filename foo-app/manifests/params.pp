# Class: foo::params
#
# This class defines default parameters used by the main module class foo
# Operating Systems differences in names and paths are addressed here 
#
# == Variables
# 
# Refer to foo class for the variables defined here.
#
# == Usage 
# 
# This class is not intended to be used directly. It may be imported or inherited by other classes
#
class foo::params {

  $install = "package",

  $install_source = "http://download.foo.com/foo.tar.gz",
 
  $install_destination = $operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => "/var/www",
    /(?i:Suse|OpenSuse)/      => "/srv/www",
    default                   => "/var/www/html",
  }

  $install_precommand  = "",

  $install_postcommand = "",

  $url_check           = "",

  $url_pattern         = "OK",

  $package = $operatingsystem ? {
    default => "foo",
  }

  $config_dir = $operatingsystem ? {
    default => "/etc/foo",
  }

  $config_file = $operatingsystem ? {
    default => "/etc/foo/foo.conf",
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
    default => "/var/lib/foo",
  }

  $log_dir = $operatingsystem ? {
    default => "/var/log",
  }

  $log_file = $operatingsystem ? {
    default => "/var/log/foo.log",
  }

}
