class baseline::lang::rust {

  $baseline_user = hiera('baseline_user', 'vagrant')

  exec {
    'download rust package':
      command => '/usr/bin/curl http://static.rust-lang.org/dist/rust-0.10-x86_64-unknown-linux-gnu.tar.gz | /bin/tar xz',
      creates => '/opt/rust-0.10-x86_64-unknown-linux-gnu',
      cwd     => '/opt',
      ;
    'source rust in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/rust.sh ]] && source /etc/profile.d/rust.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep rust.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    '/etc/profile.d/rust.sh':
      source => 'puppet:///modules/baseline/rust.sh',
      ;
    '/opt/rust':
      target  => '/opt/rust-0.10-x86_64-unknown-linux-gnu',
      ensure  => 'link',
      require => Exec['download rust package'],
      ;
  }

}
