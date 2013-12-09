class baseline::lang::go {

  $baseline_user = hiera('baseline_user', 'vagrant')

  exec {
    'download go':
      command => '/usr/bin/curl https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz | /bin/tar xz',
      cwd     => '/opt',
      creates => '/opt/go',
      require => Package['curl'],
      ;
    'source go in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/go.sh ]] && source /etc/profile.d/go.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep go.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file { '/etc/profile.d/go.sh':
    source => 'puppet:///modules/baseline/go.sh',
  }

}
