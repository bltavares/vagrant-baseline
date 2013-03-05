class baseline::lang::rust {

  $rust_package = 'rust_0.5-1_amd64.deb'

  exec {
  'download rust package':
    command => "/usr/bin/wget -O ${rust_package} http://ubuntuone.com/5y3Zqpo6IBG62OSD5wBI1O",
    cwd     => '/opt',
    creates => "/opt/${rust_package}",
    ;
  'install rust':
    command => "/usr/bin/dpkg -i /opt/${rust_package} && /bin/rm /opt/${rust_package}",
    creates => '/usr/local/bin/rustc',
    require => Exec['download rust package'],
    ;
  }

}
