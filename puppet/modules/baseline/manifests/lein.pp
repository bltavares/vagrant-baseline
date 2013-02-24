class baseline::lein {

  exec {
    'download lein':
      command => '/usr/bin/wget https://raw.github.com/technomancy/leiningen/stable/bin/lein',
      cwd     => '/usr/local/bin',
      creates => '/usr/local/bin/lein',
      ;

    'make lein executable':
      command => '/bin/chmod +x /usr/local/bin/lein',
      require => Exec['download lein'],
      ;
  }

}
