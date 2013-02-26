class baseline::lang::haskell {

  include apt::update

  package { 'haskell-platform':
    ensure  => 'latest',
    require => Class[apt::update],
  }

}
