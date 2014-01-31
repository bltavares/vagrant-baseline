class baseline::lang::racket {

  $baseline_user = hiera('baseline_user')

  file {
    '/etc/profile.d/racket.sh':
      source => 'puppet:///modules/baseline/racket.sh',
      ;
  }

  exec {
    'Download racket':
      command => '/usr/bin/curl http://download.racket-lang.org/installers/5.92/racket-5.92-x86_64-linux-ubuntu-quantal.sh -o /opt/racket-install.sh',
      cwd     => '/opt',
      creates => '/opt/racket-install.sh',
      require => Package['curl'],
      ;
    'Run racket.sh':
      command => '/bin/echo -e "no\\n4\\n\\n" | /bin/sh /opt/racket-install.sh',
      cwd     => '/opt',
      creates => '/opt/racket',
      require => Exec['Download racket'],
      ;
    'source racket in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/racket.sh ]] && source /etc/profile.d/racket.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep racket.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

}
