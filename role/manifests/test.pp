class role::test {

  include role::common

  class { "solr" :
#    install    => "package",
#    install_source => "http://www.apache.org/dist/lucene/solr/3.3.0/apache-solr-3.3.0.tgz",
    install_source => "http://10.42.42.10/apache-solr-3.4.0.tar.gz",
    install => "puppi",
    source_dir => "puppet:///modules/example42/solr/",
    puppi      => true,
  }


  
# TESTING url_parse and add_arguments functions
#  file { '/tmp/test':
#     ensure => present,
#  }

#  @file { '/tmp/test2':
#     ensure => present,
#  }

#  $options = {
#      mode => "777",
#      owner => "www-data",
#  }

#  File <<| name == "/tmp/test2" |>>   

#   $deb=add_arguments("File[/tmp/test]",$options)

#   alert("DEB: $deb")

   $url="https://my_user:my_pass@www.example42.com:8080/path/to/file.php?id=1&ret=1"
   $url_scheme=url_parse($url,scheme)
   $url_host=url_parse($url,host)
   $url_file=url_parse($url,filename)
   $url_path=url_parse($url,path)
   $url_query=url_parse($url,query)
   $url_user=url_parse($url,user)
   $url_dir=url_parse($url,filedir)
   $url_ext=url_parse($url,filetype)
   alert("$url_dir -- $url_ext -- $url_file -- $url_path -- $url_query -- $url_user -- $url_url")  

}
