class baseline::lang::io {

  $io_tarball = 'iobin-linux-x64-deb-current.zip'
  $io_deb_package = 'IoLanguage-2012.11.10-Linux-x64.deb'

  include baseline::unzip

  exec {
    'download io':
      command => "/usr/bin/wget http://iobin.suspended-chord.info/linux/${io_tarball}",
      cwd     => '/opt',
      creates => "/opt/${io_tarball}",
      ;
    'extract io':
      command => "/usr/bin/unzip ${io_tarball} -d io_lang_current",
      cwd     => '/opt',
      creates => "/opt/io_lang_current/${io_deb_package}",
      require => [Package['unzip'], Exec['download io']],
      ;
    'install io':
      command => "/usr/bin/dpkg -i ${io_deb_package}",
      cwd     => '/opt/io_lang_current',
      creates => '/usr/local/bin/io',
      require => Exec['extract io'],
      ;
  }


}
