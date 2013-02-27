class baseline::dotfiles {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  $baseline_user = hiera('baseline_user', 'vagrant')
  $baseline_dotfiles_url = hiera('baseline_dotfiles')
  $baseline_use_zsh = hiera('baseline_use_zsh', true)

  file {
    'gitconfig':
      path   => "/home/${baseline_user}/.gitconfig",
      source => 'puppet:///modules/baseline/gitconfig',
      ;
  }

  exec {
    'download dot-files':
      command => "git clone ${baseline_dotfiles_url} /home/${baseline_user}/dot-files",
      creates => "/home/${baseline_user}/dot-files",
      require => [Package['curl'], Package['git-core']],
      user    => $baseline_user,
      ;
    'install-dot-files':
      command   => "bash -c 'HOME=/home/${baseline_user} ./install.sh'",
      creates   => "/home/${baseline_user}/.baseline_dotfiles",
      cwd       => "/home/${baseline_user}/dot-files",
      logoutput => true,
      require   => Exec['download dot-files'],
      timeout   => 0,
      user      => $baseline_user,
      ;
  }

  if($baseline_use_zsh) {
    exec {
      'set shell':
        command => "chsh -s /bin/zsh ${baseline_user}",
        require => [Package['zsh'],
        ;
    }
  }
}
