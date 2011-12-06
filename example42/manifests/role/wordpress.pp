# Class: example42::role::wordpress
#
# This a role for an all-in-one wordpress (complete LAMP stack)
#
class role::wordpress {

  include example42::baseline::common

  class { "wordpress" :
    install    => "package",
    puppi      => true,
    monitor    => true,
  }

}
