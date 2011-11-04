# Class: foo-app
#
# This is the main foo-app class
#
#
# == Parameters
#
# Standard class parameters - Define foo-app web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs foo-app using the OS common packages
#     - source  : Installs foo-app downloading and extracting a specific tarball or zip file
#     - puppi   : Installs foo-app tarball or file via Puppi, creating the "puppi deploy foo-app" command
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
#   Check foo-app/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check foo-app/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url, relevant to the foo-app application, to use for testing the correct deployment of foo-app.
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
#   If defined, foo-app class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, foo-app main config file will have the parameter: source => $source
#
# [*source_dir*]
#   If defined, the whole foo-app configuration directory content is retrieved recursively from
#   the specified source (parameter: source => $source_dir , recurse => true)
#
# [*source_dir_purge*]
#   If set to true (default false)  the existing configuration directory is mirrored with the 
#   content retrieved from source_dir. (source => $source_dir , recurse => true , purge => true) 
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, foo-app main config file will have: content => content("$template")
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
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for foo-app
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#
# 
# Default class params - As defined in foo-app::params.
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
#
# [*package*]
#   The name of foo-app package 
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
class foo-app (
  $install             = $foo-app::params::install,
  $install_source      = $foo-app::params::install_source,
  $install_destination = $foo-app::params::install_destination,
  $install_precommand  = $foo-app::params::install_precommand,
  $install_postcommand = $foo-app::params::install_postcommand,
  $url_check           = $foo-app::params::url_check,
  $url_pattern         = $foo-app::params::url_pattern,
  $my_class            = "",
  $source              = "",
  $source_dir          = "",
  $source_dir_purge    = false,
  $template            = "",
  $options             = "",
  $absent              = false,
  $monitor             = false,
  $monitor_tool        = "",
  $puppi               = false,
  $debug               = false,
  $package             = $foo-app::params::package,   
  $config_dir          = $foo-app::params::config_dir,
  $config_file         = $foo-app::params::config_file,
  $config_file_mode    = $foo-app::params::config_file_mode,
  $config_file_owner   = $foo-app::params::config_file_owner,
  $config_file_group   = $foo-app::params::config_file_group,
  $data_dir            = $foo-app::params::data_dir, 
  $log_dir             = $foo-app::params::log_dir, 
  $log_file            = $foo-app::params::log_file 
  ) inherits foo-app::params {

  validate_bool($source_dir_purge , $absent , $monitor , $puppi , $debug)

  # Calculations of some variables used in the module
  $manage_package = $foo-app::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_file = $foo-app::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $foo-app::absent ? {
    true  => false ,
    default => $foo-app::disable ? {
      true    => false,
      default => true,
    }
  }


  # Installation is managed in dedicated class
  require foo-app::install

  file { "foo-app.conf":
    path    => "${foo-app::config_file}",
    mode    => "${foo-app::config_file_mode}",
    owner   => "${foo-app::config_file_owner}",
    group   => "${foo-app::config_file_group}",
    ensure  => "${foo-app::manage_file}",
    require => Class["foo-app::install"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
  }

  # The whole foo-app configuration directory can be recursively overriden
  if $foo-app::source_dir {
    file { "foo-app.dir":
      path    => "${foo-app::config_dir}",
      ensure  => directory,
      require => Class["foo-app::install"],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
    }
  }

  # Include custom class if $my_class is set
  if $foo-app::my_class {
    include $foo-app::my_class
  } 


  # Provide puppi data, if enabled ( puppi => true )
  if $foo-app::puppi == true { 
    file { "puppi_foo-app":
      path    => "${settings::vardir}/puppi/foo-app",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${foo-app::manage_file}",
      require => Class["puppi"],         
      content => template("foo-app/puppi.erb"),
    }
  }


  # Url check, if enabled ( monitor => true )
  if $foo-app::monitor == true and $foo-app::url_check != "" { 
    monitor::url { "foo-app_url":
      url     => "${foo-app::url_check}",
      pattern => "${foo-app::url_pattern}",
      port    => "${foo-app::port}",
      target  => "${fqdn}",
      tool    => "${foo-app::monitor_tool}",
      enable  => $foo-app::manage_monitor,
    }
  }


  # Include debug class is debugging is enabled 
  if $foo-app::debug == true {
    file { "debug_foo-app":
      path    => "${settings::vardir}/debug-foo-app",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$foo-app::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
