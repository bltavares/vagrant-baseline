class baseline {

  include git
  include apt::update

  $packages = [
    'aptitude',
    'curl',
    'emacs',
    'gawk',
    'vim',
    'zsh',
  ]

  package {
    $packages:
    ensure => 'latest',
    require => [Class[apt::update], Package['git-core']],
      ;
  }

}
