class baseline::buildessential {

  include apt::update

  package { 
    'build-essential':
      ensure => 'latest',
      require => Class[apt::update],
      ;
  } 

}
