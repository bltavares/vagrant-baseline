class baseline::lang::scala {

  $scala_basename = 'scala-2.10.0'
  $scala_path = "/opt/${scala_basename}/bin"

  $baseline_user = hiera('baseline_user')

  exec {
    'download scala':
      command => "/usr/bin/curl http://www.scala-lang.org/downloads/distrib/files/${scala_basename}.tgz | /bin/tar xz",
      cwd     => '/opt',
      creates => "/opt/${scala_basename}",
      require => Package['curl'],
      ;
    'source scala in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/scala.sh ]] && source /etc/profile.d/scala.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep scala.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
    'download sbt deb':
      command => '/usr/bin/wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.2/sbt.deb',
      cwd     => '/opt',
      creates => '/opt/sbt.deb',
      require => [Package['curl'], Class[java7]],
      ;
    'install sbt':
      command => '/usr/bin/dpkg -i sbt.deb',
      cwd     => '/opt',
      creates => '/usr/local/sbt',
      require => Exec['download sbt deb'],
      ;
  }

  file {
    'scala path':
      path    => '/etc/profile.d/scala.sh',
      content => template('baseline/scala.sh'),
      ;
  }

}

