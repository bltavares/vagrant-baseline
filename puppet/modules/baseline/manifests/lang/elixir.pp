class baseline::lang::elixir {

  $baseline_user = hiera('baseline_user')
  $elixir_tarball = 'v0.8.1.zip'

  package { 'unzip':
    ensure => installed,
  }

  exec {
    'download elixir':
      command  => "/usr/bin/wget http://dl.dropbox.com/u/4934685/elixir/${elixir_tarball}",
      cwd      => '/opt',
      creates => "/opt/${elixir_tarball}",
      ;
    'extract elixir':
      command  => "/usr/bin/unzip ${elixir_tarball} -d elixir",
      cwd      => '/opt',
      creates => '/opt/elixir',
      require  => Package['unzip'],
      ;
    'source elixir in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/elixir.sh ]] && source /etc/profile.d/elixir.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep elixir.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    'elixir path':
      path   => '/etc/profile.d/elixir.sh',
      source => 'puppet:///modules/baseline/elixir.sh',
      ;
  }
}
