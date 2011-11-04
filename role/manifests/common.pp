class role::common {

  # Pupeptlabs Standard Libraries
  include stdlib

  # Example42 Common Libraries
  include 42lib

  # Puppi
  include puppi

  # OpenSSH setup (with various alternative sample usage)
  class { "openssh" :
#    template => "example42/openssh/sshd_config.erb",
    # source => [ "puppet:///modules/example42/openssh/sshd_config-${hostname}" , "puppet:///modules/example42/openssh/sshd_config" ], 
    options  => {
      "X11Forwarding"   => "yes",
      "PermitRootLogin" => "yes",
      "ListenAddress"   => "0.0.0.0",
    },
    my_class => "example42::openssh",
    puppi    => true,
     debug    => true,
    # disable  => true,
    # disableboot  => true,
    # absent   => true,
  }



}
