class baseline::dotfiles {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  $baseline_user = hiera('baseline_user', 'vagrant')
  $baseline_dotfiles_url = hiera('baseline_dotfiles')

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

}
