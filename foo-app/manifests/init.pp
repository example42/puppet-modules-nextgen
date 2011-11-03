# Class: foo
#
# This is the main foo class
#
#
# == Parameters
#
# Standard class parameters - Define foo web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs foo using the OS common packages
#     - source  : Installs foo downloading and extracting a specific tarball or zip file
#     - puppi   : Installs foo tarball or file via Puppi, creating the "puppi deploy foo" command
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip. Used if install => "source" or "puppi"
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip. Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web or Application server
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check foo/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check foo/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url, relevant to the foo application, to use for testing the correct deployment of foo.
#   Used is monitor is enabled.
# 
# [*url_pattern*]
#   A string that must exist in the defined url_check that confirms that the application is running correctly
#
#
# Standard class parameters - Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations 
#   If defined, foo class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, foo main config file will have the parameter: source => $source
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, foo main config file will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options that can be used in templates for arbitrary settings.
# 
# [*absent*] 
#   Set to 'true' to remove package(s) installed by module 
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for foo
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#
# 
# Default class params - As defined in foo::params.
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
#
# [*package*]
#   The name of foo package 
# 
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# == Examples
# 
# See README
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class foo (
  $install             = $foo::params::install,
  $install_source      = $foo::params::install_source,
  $install_destination = $foo::params::install_destination,
  $install_precommand  = $foo::params::install_precommand,
  $install_postcommand = $foo::params::install_postcommand,
  $url_check           = $foo::params::url_check,
  $url_pattern         = $foo::params::url_pattern,
  $my_class            = "",
  $source              = "",
  $template            = "",
  $options             = "",
  $absent              = false,
  $monitor             = false,
  $monitor_tool        = "",
  $puppi               = false,
  $debug               = false,
  $package             = $foo::params::package,   
  $config_dir          = $foo::params::config_dir,
  $config_file         = $foo::params::config_file,
  $config_file_mode    = $foo::params::config_file_mode,
  $config_file_owner   = $foo::params::config_file_owner,
  $config_file_group   = $foo::params::config_file_group,
  $data_dir            = $foo::params::data_dir, 
  $log_dir             = $foo::params::log_dir, 
  $log_file            = $foo::params::log_file 
  ) inherits foo::params {

  validate_bool($absent , $monitor , $puppi , $debug)

  # Calculations of some variables used in the module
  $manage_package = $foo::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_file = $foo::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $foo::absent ? {
    true  => false ,
    default => $foo::disable ? {
      true    => false,
      default => true,
    }
  }


  # Installation is managed in dedicated class
  require foo::install

  file { "foo.conf":
    path    => "${foo::config_file}",
    mode    => "${foo::config_file_mode}",
    owner   => "${foo::config_file_owner}",
    group   => "${foo::config_file_group}",
    ensure  => "${foo::manage_file}",
    require => Class["foo::install"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
  }


  # Include custom class if $my_class is set
  if $foo::my_class {
    include $foo::my_class
  } 


  # Provide puppi data, if enabled ( puppi => true )
  if $foo::puppi == true { 
    file { "puppi_foo":
      path    => "${settings::vardir}/puppi/foo",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${foo::manage_file}",
      require => Class["puppi"],         
      content => template("foo/puppi.erb"),
    }
  }


  # Url check, if enabled ( monitor => true )
  if $foo::monitor == true and $foo::url_check != "" { 
    monitor::url { "foo_url":
      url     => "${foo::url_check}",
      pattern => "${foo::url_pattern}",
      port    => "${foo::port}",
      target  => "${fqdn}",
      tool    => "${foo::monitor_tool}",
      enable  => $foo::manage_monitor,
    }
  }


  # Include debug class is debugging is enabled 
  if $foo::debug == true {
    file { "debug_foo":
      path    => "${settings::vardir}/debug-foo",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$foo::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
