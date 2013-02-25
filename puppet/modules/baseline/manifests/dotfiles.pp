class baseline::dotfiles {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  $baseline_user = hiera('baseline_user', 'vagrant')

  file {
    'gitconfig':
      path   => "/home/${baseline_user}/.gitconfig",
      source => 'puppet:///modules/baseline/gitconfig',
      ;
  }

  exec {
    'set up default settings':
      command => 'curl https://gist.github.com/bltavares/2706792/raw/post-install.sh | bash',
      cwd     => "/home/${baseline_user}",
      require => [Package['curl'], Package['git-core']],
      user    => $baseline_user,
      ;

    'download dot-files':
      command => "git clone https://github.com/bltavares/dot-files.git /home/${baseline_user}/dot-files",
      creates => "/home/${baseline_user}/dot-files",
      require => Exec['set up default settings'],
      user    => $baseline_user,
      ;

    'install-dot-files':
      command => "bash -c 'HOME=/home/${baseline_user} ./install.sh'",
      creates => "/home/${baseline_user}/.zshrc",
      cwd     => "/home/${baseline_user}/dot-files",
      require => Exec['download dot-files'],
      user    => $baseline_user,
      ;

    'set shell':
      command => "chsh -s /bin/zsh ${baseline_user}",
      require => Exec['install-dot-files'],
      ;
  }
}
