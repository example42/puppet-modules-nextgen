# Class: foo_webapp
#
# This is the main foo_webapp class
#
#
# == Parameters
#
# Standard class parameters - Define foo_webapp web app specific settings
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs foo_webapp using the OS common packages
#     - source  : Installs foo_webapp downloading and extracting a specific tarball or zip file
#     - puppi   : Installs foo_webapp tarball or file via Puppi, creating the "puppi deploy foo_webapp" command
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip. Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip. Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web or Application server
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check foo_webapp/manifests/params.pp before overriding the default settings
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip. Used if install => "source" or "puppi"
#   Check foo_webapp/manifests/params.pp before overriding the default settings
#
# [*url_check*]
#   An url, relevant to the foo_webapp application, to use for testing the correct deployment of foo_webapp.
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
#   If defined, foo_webapp class will automatically "include $my_class"
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, foo_webapp main config file will have the parameter: source => $source
#
# [*source_dir*]
#   If defined, the whole foo_webapp configuration directory content is retrieved recursively from
#   the specified source (parameter: source => $source_dir , recurse => true)
#
# [*source_dir_purge*]
#   If set to true all the existing configuration directory is overriden by the 
#   content retrived from source_dir. (source => $source_dir , recurse => true , purge => true) 
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, foo_webapp main config file will have: content => content("$template")
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
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for foo_webapp
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#
# 
# Default class params - As defined in foo_webapp::params.
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
#
# [*package*]
#   The name of foo_webapp package 
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
class foo_webapp (
  $install             = $foo_webapp::params::install,
  $install_source      = $foo_webapp::params::install_source,
  $install_destination = $foo_webapp::params::install_destination,
  $install_precommand  = $foo_webapp::params::install_precommand,
  $install_postcommand = $foo_webapp::params::install_postcommand,
  $url_check           = $foo_webapp::params::url_check,
  $url_pattern         = $foo_webapp::params::url_pattern,
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
  $package             = $foo_webapp::params::package,   
  $config_dir          = $foo_webapp::params::config_dir,
  $config_file         = $foo_webapp::params::config_file,
  $config_file_mode    = $foo_webapp::params::config_file_mode,
  $config_file_owner   = $foo_webapp::params::config_file_owner,
  $config_file_group   = $foo_webapp::params::config_file_group,
  $data_dir            = $foo_webapp::params::data_dir, 
  $log_dir             = $foo_webapp::params::log_dir, 
  $log_file            = $foo_webapp::params::log_file 
  ) inherits foo_webapp::params {

  validate_bool($source_dir_purge, $absent , $monitor , $puppi , $debug)

  # Calculations of some variables used in the module
  $manage_package = $foo_webapp::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_file = $foo_webapp::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $foo_webapp::absent ? {
    true  => false ,
    default => $foo_webapp::disable ? {
      true    => false,
      default => true,
    }
  }


  # Installation is managed in dedicated class
  require foo_webapp::install

  file { "foo_webapp.conf":
    path    => "${foo_webapp::config_file}",
    mode    => "${foo_webapp::config_file_mode}",
    owner   => "${foo_webapp::config_file_owner}",
    group   => "${foo_webapp::config_file_group}",
    ensure  => "${foo_webapp::manage_file}",
    require => Class["foo_webapp::install"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
  }

  # Whole foo_webapp configuration directory can be recursively overriden
  if $foo_webapp::source_dir {
    file { "foo_webapp.dir":
      path    => "${foo_webapp::config_dir}",
      ensure  => directory,
      require => Class["foo_webapp::install"],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
    }
  }

  # Include custom class if $my_class is set
  if $foo_webapp::my_class {
    include $foo_webapp::my_class
  } 


  # Provide puppi data, if enabled ( puppi => true )
  if $foo_webapp::puppi == true { 
    $puppivars=get_class_args()
    file { "puppi_foo_webapp":
      path    => "${settings::vardir}/puppi/foo_webapp",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${foo_webapp::manage_file}",
      require => Class["puppi"],         
      content => inline_template("<%= puppivars.to_yaml %>"),
    }
  }


  # Url check, if enabled ( monitor => true )
  if $foo_webapp::monitor == true and $foo_webapp::url_check != "" { 
    monitor::url { "foo_webapp_url":
      url     => "${foo_webapp::url_check}",
      pattern => "${foo_webapp::url_pattern}",
      port    => "${foo_webapp::port}",
      target  => "${fqdn}",
      tool    => "${foo_webapp::monitor_tool}",
      enable  => $foo_webapp::manage_monitor,
    }
  }


  # Include debug class is debugging is enabled 
  if $foo_webapp::debug == true {
    file { "debug_foo_webapp":
      path    => "${settings::vardir}/debug-foo_webapp",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$foo_webapp::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
