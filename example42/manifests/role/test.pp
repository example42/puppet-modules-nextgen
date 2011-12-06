# Class: example42::role::test
#
# This a test role for experiments and tests
#
class example42::role::test {

  include example42::baseline::common

  class { "solr" :
#    install    => "package",
#    install_source => "http://www.apache.org/dist/lucene/solr/3.3.0/apache-solr-3.3.0.tgz",
    install_source => "http://10.42.42.10/apache-solr-3.4.0.tar.gz",
    install => "puppi",
    source_dir => "puppet:///modules/example42/solr/",
    puppi      => true,
  }

}
