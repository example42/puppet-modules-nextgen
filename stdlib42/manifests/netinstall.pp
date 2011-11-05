define netinstall (
  $url,
  $extracted_dir = "",
  $destination_dir,
  $owner = "root",
  $group = "root",
  $work_dir = "/var/tmp",
  $extract_command = "",
  $preextract_command = "",
  $postextract_command = ""
  # $postextract_command = "./configure ; make ; make install"
  ) {

  $source_filename = url_parse($url,"filename")
  $source_filetype = url_parse($url,"filetype")
  $source_dirname = url_parse($url,"filedir")

  $real_extracted_dir = $extracted_dir ? {
    ''      => $source_dirname,
    default => $extracted_dir,
  }

  $real_extract_command = $extract_command ? {
    '' => $source_filetype ? {
      ".tgz"     => "tar -zxf",
      ".tar.gz"  => "tar -zxf",
      ".tar.bz2" => "tar -jxf",
      ".tar"     => "tar -xf",
      ".zip"     => "zip -d",
    },
    default => "$extract_command",
  }
 
  if $preextract_command {
    exec {
      "PreExtract $source_filename":
        command     => $preextract_command,
        before      => Exec["Extract $source_filename"],
        refreshonly => true,
        path        => "/bin:/sbin:/usr/bin:/usr/sbin",
    }
  }

  exec {
    "Retrieve $url":
      cwd     => "$work_dir",
      command => "wget $url",
      creates => "$work_dir/$source_filename",
      timeout => 3600,
      path    => "/bin:/sbin:/usr/bin:/usr/sbin",
  }

  exec {
    "Extract $source_filename":
      command => "mkdir -p $destination_dir && cd $destination_dir && $real_extract_command $work_dir/$source_filename",
      unless  => "find $destination_dir | grep $real_extracted_dir",
      creates => "${destination_dir}/${real_extracted_dir}",
      require => Exec["Retrieve $url"],
      path    => "/bin:/sbin:/usr/bin:/usr/sbin",
  }

  if $postextract_command {
    exec {
      "PostExtract $source_filename":
        command     => $postextract_command,
        cwd         => "$destination_dir/$real_extracted_dir",
        subscribe   => Exec["Extract $source_filename"],
        refreshonly => true,
        timeout     => 3600,
        require     => Exec["Retrieve $url"],  
        path        => "/bin:/sbin:/usr/bin:/usr/sbin",
    }
  }

}

