class baseline::lang::prolog {

  include apt::update
  include baseline::checkinstall
  include gcc

  $packages = [
    'chrpath',
    'libncurses5-dev',
    'libreadline-dev',
    'libunwind7-dev',
    'libgmp-dev',
    'libssl-dev',
    'unixodbc-dev',
    'zlib1g-dev',
    'libarchive-dev',
    'libossp-uuid-dev',
  ]

  package {
    $packages:
      ensure  => 'latest',
      require => Class[apt::update],
  }

  $swipl_basename = 'pl-6.2.6'
  $swipl_tarball = "${swipl_basename}.tar.gz"

  exec {
    'download swipl':
      command => "/usr/bin/wget http://www.swi-prolog.org/download/stable/src/${swipl_tarball}",
      creates => "/opt/${swipl_tarball}",
      cwd     => '/opt',
      ;
    'extract swipl':
      command => "/bin/tar xf ${swipl_tarball}",
      creates => "/opt/${swipl_basename}",
      cwd     => '/opt',
      require => Exec['download swipl'],
      ;
    'configure and make swipl':
      command => "/opt/${swipl_basename}/configure && make",
      creates => "/opt/${swipl_basename}/Makefile",
      cwd     => "/opt/${swipl_basename}",
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      require => [Package[$packages], Class[gcc]],
      ;
    'install swipl':
      command => '/usr/bin/checkinstall -D',
      creates => '/usr/local/bin/swipl',
      cwd     => "/opt/${swipl_basename}",
      require => [Exec['configure and make swipl'], Class[baseline::checkinstall]],
      ;
  }


}
