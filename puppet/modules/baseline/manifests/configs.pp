class baseline::configs {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  $baseline_user = hiera('baseline_user', 'vagrant')
  $baseline_use_zsh = hiera('baseline_use_zsh', true)

  file {
    'gitconfig':
      path   => "/home/${baseline_user}/.gitconfig",
      source => 'puppet:///modules/baseline/gitconfig',
      ;
    'baseline.sh':
      path => '/etc/profile.d/baseline.sh',
      source => 'puppet:///modules/baseline/baseline.sh',
      ;
  }

  if($baseline_use_zsh) {
    exec {
      'set shell':
        command => "chsh -s /bin/zsh ${baseline_user}",
        require => Package['zsh'],
        ;
      'source vagrant_ruby in zshenv':
        command => "/bin/echo '[[ -f /etc/profile.d/vagrant_ruby.sh ]] && source /etc/profile.d/vagrant_ruby.sh' >> /home/${baseline_user}/.zshenv",
        unless  => "/bin/grep vagrant_ruby.sh /home/${baseline_user}/.zshenv 2> /dev/null",
        ;
      'source baseline.sh in zshenv':
        command => "/bin/echo '[[ -f /etc/profile.d/baseline.sh ]] && source /etc/profile.d/baseline.sh' >> /home/${baseline_user}/.zshenv",
        unless  => "/bin/grep baseline.sh /home/${baseline_user}/.zshenv 2> /dev/null",
    }
  }
}
