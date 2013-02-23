class baseline::checkinstall {

  include apt::update

  package { 'checkinstall':
    ensure  => 'latest',
    require => Class[apt::update],
  }

}
