class baseline::lang::prolog {

  include apt

  apt::ppa { 'ppa:swi-prolog/stable': }->
  package { 'swi-prolog':
    ensure => 'latest',
  }
}
