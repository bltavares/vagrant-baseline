class baseline {

  include git
  include baseline::configs
  Exec['update apt'] -> Package <| |>

  $packages = [
    'aptitude',
    'curl',
    'emacs',
    'gawk',
    'mercurial',
    'vim',
    'zsh',
    'tmux',
    'exuberant-ctags',
  ]

  package {
    $packages:
      ensure  => 'latest',
      require => Package['git-core'],
      ;
  }

  exec { 'update apt':
    command => '/usr/bin/apt-get update',
    ;
  }

  class { 'avahi':
    firewall => true,
    ;
  }

}
