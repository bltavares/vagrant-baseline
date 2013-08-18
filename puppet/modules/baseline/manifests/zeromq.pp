class baseline::zeromq {

  include gcc
  include baseline::checkinstall
  include baseline::libtool

  $packages = [
    'autoconf', 
    'automake',
    'uuid-dev',
  ]
  package { $packages:
    ensure  => latest,
  } -> Exec['download zeromq']

  $zeromq_basename = 'zeromq-3.2.3'

  exec {
    'download zeromq':
      command => "/usr/bin/curl http://download.zeromq.org/${zeromq_basename}.tar.gz | /bin/tar xz",
      cwd     => '/opt',
      creates => "/opt/${zeromq_basename}",
      require => Package['curl'],
      ;

    'configure and make zeromq':
      command => "/opt/${zeromq_basename}/configure && /usr/bin/make",
      creates => "/opt/${zeromq_basename}/Makefile",
      cwd     => "/opt/${zeromq_basename}",
      require => [Class[gcc] , Exec['download zeromq'], Class[baseline::libtool]],
      ;

    'install zeromq':
      command => '/usr/bin/checkinstall -D',
      creates => '/usr/local/lib/libzmq.so',
      cwd     => "/opt/${zeromq_basename}",
      require => [Class[baseline::checkinstall], Exec['configure and make zeromq']],
      ;

    'update lib paths':
      command => '/sbin/ldconfig',
      require => Exec['install zeromq'],
      ;
  }


}
