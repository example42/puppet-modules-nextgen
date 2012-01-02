class openssh::example42 inherits openssh  {

  # Just testing
  file { "/tmp/openssh": 
    ensure => present ,
  }

  File["openssh.conf"] {
    content => template("example42/openssh/sshd_config-my_class.erb"),
  }

}
