class role::test {

  include role::common

  class { "solr" :
    install    => "package",
    source_dir => "puppet:///modules/example42/solr/",
    puppi      => true,
  }


  
# TESTING uri_parse and add_arguments functions
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

#   $url="https://my_user:my_pass@www.example42.com:8080/path/to/file.php?id=1&ret=1"
#   $url_scheme=uri_parse($url,scheme)
#   $url_host=uri_parse($url,host)
#   $url_file=uri_parse($url,file)
#   $url_path=uri_parse($url,path)
#   $url_query=uri_parse($url,query)
#   $url_user=uri_parse($url,user)
#   $url_url=uri_parse($url,schae)
#   alert("$url_scheme -- $url_host -- $url_file -- $url_path -- $url_query -- $url_user -- $url_url")  

}
