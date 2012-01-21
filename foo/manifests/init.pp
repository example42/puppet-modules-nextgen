# = Class: foo
#
# This is the main foo class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, foo class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $foo_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, foo main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $foo_source
#
# [*source_dir*]
#   If defined, the whole foo configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $foo_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $foo_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, foo main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $foo_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $foo_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $foo_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $foo_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $foo_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $foo_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for foo checks
#   Can be defined also by the (top scope) variables $foo_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $foo_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $foo_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $foo_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $foo_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for foo port(s)
#   Can be defined also by the (top scope) variables $foo_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling foo. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $foo_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $foo_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $foo_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $foo_audit_only
#   and $audit_only
#
# Default class params - As defined in foo::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of foo package
#
# [*service*]
#   The name of foo service
#
# [*service_status*]
#   If the foo service init script supports status argument
#
# [*process*]
#   The name of foo process
#
# [*process_args*]
#   The name of foo arguments.
#   Used only in case the foo process name is generic (java, ruby...)
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
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
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
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $foo_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $foo_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include foo"
# - Call foo as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class foo (
  $my_class          = $foo::params::my_class,
  $source            = $foo::params::source,
  $source_dir        = $foo::params::source_dir,
  $source_dir_purge  = $foo::params::source_dir_purge,
  $template          = $foo::params::template,
  $options           = $foo::params::options,
  $absent            = $foo::params::absent,
  $disable           = $foo::params::disable,
  $disableboot       = $foo::params::disableboot,
  $monitor           = $foo::params::monitor,
  $monitor_tool      = $foo::params::monitor_tool,
  $monitor_target    = $foo::params::monitor_target,
  $puppi             = $foo::params::puppi,
  $puppi_helper      = $foo::params::puppi_helper,
  $firewall          = $foo::params::firewall,
  $firewall_tool     = $foo::params::firewall_tool,
  $firewall_src      = $foo::params::firewall_src,
  $firewall_dst      = $foo::params::firewall_dst,
  $debug             = $foo::params::debug,
  $audit_only        = $foo::params::audit_only,
  $package           = $foo::params::package,
  $service           = $foo::params::service,
  $service_status    = $foo::params::service_status,
  $process           = $foo::params::process,
  $process_args      = $foo::params::process_args,
  $config_dir        = $foo::params::config_dir,
  $config_file       = $foo::params::config_file,
  $config_file_mode  = $foo::params::config_file_mode,
  $config_file_owner = $foo::params::config_file_owner,
  $config_file_group = $foo::params::config_file_group,
  $config_file_init  = $foo::params::config_file_init,
  $pid_file          = $foo::params::pid_file,
  $data_dir          = $foo::params::data_dir,
  $log_dir           = $foo::params::log_dir,
  $log_file          = $foo::params::log_file,
  $port              = $foo::params::port,
  $protocol          = $foo::params::protocol
  ) inherits foo::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $foo::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_service_enable = $foo::bool_disableboot ? {
    true    => false,
    default => $foo::bool_disable ? {
      true    => false,
      default => $foo::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $foo::bool_disable ? {
    true    => 'stopped',
    default =>  $foo::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_file = $foo::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $foo::bool_absent == true or $foo::bool_disable == true or $foo::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $foo::bool_absent == true or $foo::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $foo::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $foo::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $foo::source ? {
    ''        => undef,
    default   => $foo::source,
  }

  $manage_file_content = $foo::template ? {
    ''        => undef,
    default   => template($foo::template),
  }

  ### Managed resources
  package { 'foo':
    ensure => $foo::manage_package,
    name   => $foo::package,
  }

  service { 'foo':
    ensure     => $foo::manage_service_ensure,
    name       => $foo::service,
    enable     => $foo::manage_service_enable,
    hasstatus  => $foo::service_status,
    pattern    => $foo::process,
    require    => Package['foo'],
    subscribe  => File['foo.conf'],
  }

  file { 'foo.conf':
    ensure  => $foo::manage_file,
    path    => $foo::config_file,
    mode    => $foo::config_file_mode,
    owner   => $foo::config_file_owner,
    group   => $foo::config_file_group,
    require => Package['foo'],
    notify  => Service['foo'],
    source  => $foo::manage_file_source,
    content => $foo::manage_file_content,
    replace => $foo::manage_file_replace,
    audit   => $foo::manage_audit,
  }

  # The whole foo configuration directory can be recursively overriden
  if $foo::source_dir {
    file { 'foo.dir':
      ensure  => directory,
      path    => $foo::config_dir,
      require => Class['foo::install'],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $foo::manage_file_replace,
      audit   => $foo::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $foo::my_class {
    include $foo::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $foo::bool_puppi == true {
    $puppivars=get_class_args()
    file { 'puppi_foo':
      ensure  => $foo::manage_file,
      path    => "${settings::vardir}/puppi/foo",
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      require => Class['puppi'],
      content => inline_template('<%= puppivars.to_yaml %>'),
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $foo::bool_monitor == true {
    monitor::port { "foo_${foo::protocol}_${foo::port}":
      protocol => $foo::protocol,
      port     => $foo::port,
      target   => $foo::params::monitor_target,
      tool     => $foo::monitor_tool,
      enable   => $foo::manage_monitor,
    }
    monitor::process { 'foo_process':
      process  => $foo::process,
      service  => $foo::service,
      pidfile  => $foo::pid_file,
      tool     => $foo::monitor_tool,
      enable   => $foo::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $foo::bool_firewall == true {
    firewall { "foo_${foo::protocol}_${foo::port}":
      source      => $foo::firewall_source,
      destination => $foo::firewall_destination,
      protocol    => $foo::protocol,
      port        => $foo::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $foo::firewall_tool,
      enable      => $foo::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $foo::bool_debug == true {
    file { 'debug_foo':
      ensure  => $foo::manage_file,
      path    => "${settings::vardir}/debug-foo",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
