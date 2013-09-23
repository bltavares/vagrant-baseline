class baseline::gradle {

  $baseline_user = hiera('baseline_user', 'vagrant')
  $gradle_basename = 'gradle-1.7'

  include baseline::unzip

  exec {
    'download gradle':
      command => "/usr/bin/wget http://services.gradle.org/distributions/${gradle_basename}-bin.zip -O $gradle_basename.zip",
      cwd     => '/opt',
      creates => "/opt/${gradle_basename}",
      ;
    'extract gradle':
      command => "/usr/bin/unzip ${gradle_basename}",
      cwd     => '/opt',
      creates => "/opt/${gradle_basename}",
      require => [Exec['download gradle'], Package['unzip']],
      ;
    'source gradle in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/gradle.sh ]] && source /etc/profile.d/gradle.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep gradle.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    '/opt/gradle':
      ensure  => 'link',
      target  => "/opt/${gradle_basename}",
      require => Exec['extract gradle'],
      ;
    'gradle path':
      path   => '/etc/profile.d/gradle.sh',
      source => 'puppet:///modules/baseline/gradle.sh',
      ;
  }
}
