class baseline::couchdb {

  include gcc
  include baseline::checkinstall

  $packages = [
    'libmozjs185-dev',
    'libicu-dev',
    'libcurl4-gnutls-dev',
    'libtool',
  ]
  package { $packages:
    ensure  => latest,
  } -> Exec['install couchdb']

  $baseline_user = hiera('baseline_user', 'vagrant')
  $couchdb_basename = 'apache-couchdb-1.2.1'

  exec {
    'create couchdb user':
      command => '/usr/sbin/adduser --disabled-login --disabled-password --no-create-home couchdb',
      unless  => '/bin/grep couchdb /etc/passwd',
      ;

    'download couchdb':
      command => "/usr/bin/curl http://www.us.apache.org/dist/couchdb/1.2.1/${couchdb_basename}.tar.gz | /bin/tar xz",
      cwd     => '/opt',
      creates => "/opt/${couchdb_basename}",
      require => Package['curl'],
      ;

    'configure and make couchdb':
      command => "/opt/${couchdb_basename}/configure && /usr/bin/env HOME=${baseline_user} /usr/bin/make",
      creates => "/opt/${couchdb_basename}/Makefile",
      cwd     => "/opt/${couchdb_basename}",
      require => [Class[gcc] , Exec['download couchdb']],
      ;

    'install couchdb':
      command => '/usr/bin/checkinstall -D',
      creates => '/usr/local/bin/couchdb',
      cwd     => "/opt/${couchdb_basename}",
      require => [Class[baseline::checkinstall], Exec['configure and make couchdb']],
      ;
  }


  File { require => [Exec['create couchdb user'], Exec['install couchdb']], }
  file {
    '/usr/local/var/log/couchdb':
      ensure  => present,
      group   => 'couchdb',
      owner   => 'couchdb',
      recurse => true,
      ;
    '/usr/local/var/lib/couchdb':
      ensure  => present,
      group   => 'couchdb',
      owner   => 'couchdb',
      recurse => true,
      ;
    '/usr/local/var/run/couchdb':
      ensure  => present,
      group   => 'couchdb',
      owner   => 'couchdb',
      recurse => true,
      ;
    '/etc/init.d/couchdb':
      ensure => link,
      target => '/usr/local/etc/init.d/couchdb',
      ;
  }

  service { 'couchdb':
    ensure  => running,
    enable  => true,
    require => File['/etc/init.d/couchdb'],
  }

}
