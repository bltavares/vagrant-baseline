class baseline {

  class { 'apt':
    stage             => 'bootstrap',
    always_apt_update => true,
    ;
  }

  $packages = [
    'aptitude',
    'curl',
    'emacs',
    'gawk',
    'git-core',
    'meld',
    'mplayer',
    'vim-gnome',
    'vim-gtk',
    'zsh',
  ]

  package {
    $packages:
    ensure => 'latest'
      ;
  }

  exec {
    'set up default settings':
      command => '/usr/bin/curl https://gist.github.com/bltavares/2706792/raw/post-install.sh | /bin/bash',
      require => [Package['curl'], Package['git-core']],
      user    => 'vagrant',
    ;

  }

}
