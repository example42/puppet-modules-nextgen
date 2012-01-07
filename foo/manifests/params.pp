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
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class foo::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'foo',
  }

  $service = $::operatingsystem ? {
    default                   => 'foo',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'foo',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/foo',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/foo/foo.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/foo',
    default                   => '/etc/sysconfig/foo',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/foo.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/foo',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/foo',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/syslog',
    default                   => '/var/log/messages',
  }

  $port = $::foo_port ? {
    ''      => '42',                    # Default value
    default => $::foo_port,
  }

  $protocol = $::foo_protocol ? {
    ''      => 'tcp',                   # Default value
    default => $::foo_protocol,
  }


  ### General variables that affect module's behaviour
  # They can be set at top scope level or in a ENC

  $my_class = $::foo_my_class ? {
    ''      => '',                      # Default value
    default => $::foo_my_class,
  }

  $source = $::foo_source ? {
    ''      => '',                      # Default value
    default => $::foo_source,
  }

  $source_dir = $::foo_source_dir ? {
    ''      => '',                      # Default value
    default => $::foo_source_dir,
  }

  $source_dir_purge = $::foo_source_dir_purge ? {
    ''      => false,                   # Default value
    default => $::foo_source_dir_purge,
  }

  $template = $::foo_template ? {
    ''      => '',                      # Default value
    default => $::foo_template,
  }

  $options = $::foo_options ? {
    ''      => '',                      # Default value
    default => $::foo_options,
  }

  $absent = $::foo_absent ? {
    ''      => false,                   # Default value
    default => $::foo_absent,
  }

  $disable = $::foo_disable ? {
    ''      => false,                   # Default value
    default => $::foo_disable,
  }

  $disableboot = $::foo_disableboot ? {
    ''      => false,                   # Default value
    default => $::foo_disableboot,
  }


  ### General module variables that can have a site or per module default
  # They can be set at top scope level or in a ENC

  $monitor = $::foo_monitor ? {
    ''      => $::monitor ? {
      ''      => false,                # Default value
      default => $::monitor,
    },
    default => $::foo_monitor,
  }

  $monitor_tool = $::foo_monitor_tool ? {
    ''      => $::monitor_tool ? {
      ''      => '',                   # Default value
      default => $::monitor_tool,
    },
    default => $::foo_monitor_tool,
  }

  $monitor_target = $::foo_monitor_target ? {
    ''      => $::monitor_target ? {
      ''      => $::ipaddress,         # Default value
      default => $::monitor_target,
    },
    default => $::foo_monitor_target,
  }

  $firewall = $::foo_firewall ? {
    ''      => $::firewall ? {
      ''      => false,                # Default value
      default => $::firewall,
    },
    default => $::foo_firewall,
  }

  $firewall_tool = $::foo_firewall_tool ? {
    ''      => $::firewall_tool ? {
      ''      => '',                   # Default value
      default => $::firewall_tool,
    },
    default => $::foo_firewall_tool,
  }

  $firewall_src = $::foo_firewall_src ? {
    ''      => $::firewall_src ? {
      ''      => '0.0.0.0/0',          # Default value
      default => $::firewall_src,
    },
    default => $::foo_firewall_src,
  }

  $firewall_dst = $::foo_firewall_dst ? {
    ''      => $::firewall_dst ? {
      ''      => $::ip_address,        # Default value
      default => $::firewall_dst,
    },
    default => $::foo_firewall_dst,
  }

  $puppi = $::foo_puppi ? {
    ''      => $::puppi ? {
      ''      => false,                # Default value
      default => $::puppi,
    },
    default => $::foo_puppi,
  }

  $puppi_helper = $::foo_puppi_helper ? {
    ''      => $::puppi_helper ? {
      ''      => 'standard',           # Default value
      default => $::puppi_helper,
    },
    default => $::foo_puppi_helper,
  }

  $debug = $::foo_debug ? {
    ''      => $::debug ? {
      ''      => false,                # Default value
      default => $::debug,
    },
    default => $::foo_debug,
  }

  $audit_only = $::foo_audit_only ? {
    ''      => $::audit_only ? {
      ''      => false,                # Default value
      default => $::audit_only,
    },
    default => $::foo_audit_only,
  }

}
