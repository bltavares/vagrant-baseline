class baseline::lang::groovy {

  $baseline_user = hiera('baseline_user', 'vagrant')
  $groovy_basename = 'groovy-2.2.1'

  include baseline::unzip

  exec {
    'download groovy':
      command => "/usr/bin/wget http://dist.groovy.codehaus.org/distributions/groovy-binary-2.2.1.zip -O $groovy_basename.zip",
      cwd     => '/opt',
      creates => "/opt/${groovy_basename}.zip",
      ;
    'extract groovy':
      command => "/usr/bin/unzip ${groovy_basename}",
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
