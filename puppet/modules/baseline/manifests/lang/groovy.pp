class baseline::lang::groovy {

  $baseline_user = hiera('baseline_user', 'vagrant')
  $groovy_basename = 'groovy-2.1.7'
  $groovy_tarball = 'groovy-binary-2.1.7.zip'

  include baseline::unzip

  exec {
    'download groovy':
      command => "/usr/bin/wget http://dist.groovy.codehaus.org/distributions/${groovy_tarball}",
      cwd     => '/opt',
      creates => "/opt/${groovy_tarball}",
      ;
    'extract groovy':
      command => "/usr/bin/unzip ${groovy_tarball}",
      cwd     => '/opt',
      creates => "/opt/${groovy_basename}",
      require => [Exec['download groovy'], Package['unzip']],
      ;
    'source groovy in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/groovy.sh ]] && source /etc/profile.d/groovy.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep groovy.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    '/opt/groovy':
      ensure  => 'link',
      target  => "/opt/${groovy_basename}",
      require => Exec['extract groovy'],
      ;
    'groovy path':
      path   => '/etc/profile.d/groovy.sh',
      source => 'puppet:///modules/baseline/groovy.sh',
      ;
  }
}
