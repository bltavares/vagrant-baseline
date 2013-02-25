class baseline::lang::nodejs {

  apt::ppa { 'ppa:chris-lea/node.js': }
  class { '::nodejs':
    require => Apt::Ppa['ppa:chris-lea/node.js']
  }

}
