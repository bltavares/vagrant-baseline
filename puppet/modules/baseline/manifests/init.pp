class baseline {

  include git
  include apt::update
  Class[apt::update] -> Package <| provider == 'apt' |>

  $packages = [
    'aptitude',
    'curl',
    'emacs',
    'gawk',
    'mercurial',
    'vim',
    'zsh',
  ]

  package {
    $packages:
      ensure  => 'latest',
      require => Package['git-core'],
      ;
  }

  class { 'avahi':
    firewall => true,
    ;
  }

}
