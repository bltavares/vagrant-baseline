class baseline::lang::sml {

  include gcc

  $baseline_user = hiera('baseline_user')

  file {
    '/opt/sml':
      ensure => 'directory',
      ;
    '/etc/profile.d/sml.sh':
      source => 'puppet:///modules/baseline/sml.sh',
      ;
  }


  package {
    ['gcc-multilib', 'g++-multilib']:
      ensure => 'latest',
      ;
  }


  exec {
    'Download sml':
      command => '/usr/bin/curl  http://www.smlnj.org/dist/working/110.74/config.tgz | /bin/tar xz',
      cwd     => '/opt/sml',
      creates => '/opt/sml/config',
      require => [File['/opt/sml'], Package['curl']],
      ;
    'Run config/install.sh':
      command => '/opt/sml/config/install.sh',
      cwd     => '/opt/sml',
      creates => '/opt/sml/bin/sml',
      require => Exec['Download sml'],
      ;
    'source sml in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/sml.sh ]] && source /etc/profile.d/sml.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep sml.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

}
