# Class: example42::role::rspec
#
# This a role used for automated rspec tests
#
class example42::role::rspec {

  include stdlib
  include stdlib42

  class { "openssh": 
#    my_class          => undef ,
#    source            => undef ,
#    source_dir        => '' ,
#    source_dir_purge  => undef ,
#    template          => undef ,
#    options           => undef ,
#    absent            => false ,
#    disable           => false ,
#    disableboot       => false ,
#    monitor           => false ,
#    monitor_tool      => undef ,
#    monitor_target    => undef ,
#    puppi             => false ,
#    puppi_helper      => undef ,
#    firewall          => false ,
#    firewall_tool     => undef ,
#    firewall_src      => undef ,
#    firewall_dst      => undef ,
#    debug             => false ,
#    audit_only        => false ,
  }

}
