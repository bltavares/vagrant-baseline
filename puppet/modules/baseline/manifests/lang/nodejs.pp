class baseline::lang::nodejs {

  include apt

  apt::ppa { 'ppa:chris-lea/node.js': }
  package { 'nodejs':
    ensure  => 'latest',
    require => Apt::Ppa['ppa:chris-lea/node.js'],
  }

}
