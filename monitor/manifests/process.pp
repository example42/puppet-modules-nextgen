define monitor::process (
  $process,
  $argument="",
  $service,
  $pidfile,
  $tool,
  $enable=true
  ) {
  validate_bool($enable)

  $ensure = $enable ? {
    false => "absent",
    true  => "present",
  }

  if ($tool =~ /munin/) {
  }

  if ($tool =~ /collectd/) {
  }

  if ($tool =~ /monit/) {
    monit::checkpid { "${name}":
      pidfile      => "${pidfile}",
      process      => "${process}${argument}",
      startprogram => "/etc/init.d/${service} start",
      stopprogram  => "/etc/init.d/${service} stop",
      enable       => $enable,
    }
  }

  if ($tool =~ /nagios/) {
    nagios::service { "$name":
      ensure    => $ensure,
      check_command => $process ? {
        undef   => "check_nrpe!check_process!${name}" ,
        default => $argument ? {
          undef   => "check_nrpe!check_process!${process}" ,
          ""      => "check_nrpe!check_process!${process}" ,
          default => "check_nrpe!check_processwitharg!${process}!${argument}" ,
        }
      }
    }
  }

  if ($tool =~ /puppi/) {
    puppi::check { "$name":
      enable   => $enable,
      hostwide => "yes",
      command  => $process ? {
        undef   => "check_procs -c 1: -C ${name}" ,
        default => $argument ? {
          undef   => "check_procs -c 1: -C ${process}" ,
          ""      => "check_procs -c 1: -C ${process}" ,
          default => "check_procs -c 1: -C ${process} -a ${argument}" ,
        }
      }
    }
  }

}
