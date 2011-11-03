class example42::role::test {

  include stdlib

  file { '/tmp/test':
     ensure => present,
  }

  @file { '/tmp/test2':
     ensure => present,
  }

  $options = {
      mode => "777",
      owner => "www-data",
  }

  File <<| name == "/tmp/test2" |>>   

   $deb=add_arguments("File[/tmp/test]",$options)

   alert("DEB: $deb")

   $url="https://my_user:my_pass@www.example42.com:8080/path/to/file.php?id=1&ret=1"
   $url_scheme=url_parse($url,scheme)
   $url_host=url_parse($url,host)
   $url_file=url_parse($url,file)
   $url_path=url_parse($url,path)
   $url_query=url_parse($url,query)
   $url_user=url_parse($url,user)
   $url_url=url_parse($url,schae)
#    alert("$url_scheme -- $url_host -- $url_file -- $url_path -- $url_query -- $url_user -- $url_url")  

}
