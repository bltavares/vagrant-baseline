class baseline::lang::scala {

  $scala_basename = 'scala-2.10.0'
  $scala_tarball = "${scala_basename}.tgz"
  $scala_path = "/opt/${scala_basename}/bin"

  $baseline_user = hiera("baseline_user")

  exec {
    'download scala':
      command => "/usr/bin/wget http://www.scala-lang.org/downloads/distrib/files/${scala_tarball}",
      cwd     => '/opt',
      creates => "/opt/${scala_tarball}",
      ;
    'extract scala':
      command => "/bin/tar xf ${scala_tarball}",
      cwd     => '/opt',
      creates => "/opt/${scala_basename}",
      require => Exec['download scala'],
      ;
    'source scala in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/scala.sh ]] && source /etc/profile.d/scala.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep scala.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
    'download sbt deb':
      command => '/usr/bin/wget http://scalasbt.artifactoryonline.com/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.12.2/sbt.deb',
      cwd     => '/opt',
      creates => '/opt/sbt.deb',
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
      path => '/etc/profile.d/scala.sh',
      content  => template("baseline/scala.sh"),
      ;
  }

}

