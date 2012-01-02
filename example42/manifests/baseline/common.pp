# Class: example42::baseline::common
#
# This a common baseline that can be applied to all nodes
#
class example42::baseline::common {

  # Puppetlabs Standard Libraries
  include stdlib

  # Example42 Common Libraries
  include stdlib42

  # Puppi
  include puppi

  # OpenSSH setup 
  class { "openssh":  
    monitor => true,
#    template => "example42/openssh/sshd_config.erb",
#    source => [ "puppet:///modules/example42/openssh/sshd_config-${hostname}" , "puppet:///modules/example42/openssh/ss
#    my_class => "openssh::example42", 
  }

}
