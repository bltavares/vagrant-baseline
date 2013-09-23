class baseline::lang::java {
  include java7

  $baseline_user = hiera('baseline_user', 'vagrant')
  $maven_basename = 'apache-maven-3.1.0'
  $maven_url = "http://www.us.apache.org/dist/maven/maven-3/3.1.0/binaries/${maven_basename}-bin.tar.gz"

  exec {
    'Download maven':
      command => "/usr/bin/curl ${maven_url} | /bin/tar xzv",
      creates => "/opt/${maven_basename}",
      cwd     => '/opt',
      require => Package['curl'],
      ;
    'source maven bin':
      command => "/bin/echo '[[ -f /etc/profile.d/maven.sh ]] && source /etc/profile.d/maven.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep maven.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    '/etc/profile.d/maven.sh':
      source => 'puppet:///modules/baseline/maven.sh'
      ;
    '/opt/maven':
      ensure  => 'link',
      target  => "/opt/${maven_basename}",
      require => Exec['Download maven'],
      ;
  }
}
