class baseline::lang::rust {

  $rust_package = 'rust_0.8-1_amd64.deb'
  $rust_md5 = '7f2e19bc5cde47e143b7484ecda0207f'

  exec {
    'download rust package':
      command => "/usr/bin/wget -O ${rust_package} https://copy.com/voMAE7mI19Jf",
      cwd     => '/opt',
      notify  => Exec['install rust'],
      onlyif  => "/bin/bash -c '[ ! -f /opt/${rust_package} ] || ! md5sum /opt/${rust_package} | grep ${rust_md5} > /dev/null '",
      timeout => 0,
      ;
    'install rust':
      command     => "/usr/bin/dpkg -i /opt/${rust_package}",
      refreshonly => true,
      require     => Exec['download rust package'],
      ;
  }

}
