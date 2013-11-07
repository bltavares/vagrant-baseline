class baseline::lang::java {
  include java7

  $baseline_user = hiera('baseline_user', 'vagrant')

  $maven_basename = 'apache-maven-3.1.1'
  $maven_url = "http://www.us.apache.org/dist/maven/maven-3/3.1.1/binaries/${maven_basename}-bin.tar.gz"

  $ant_basename = 'apache-ant-1.9.2'
  $ant_url = "http://www.us.apache.org/dist//ant/binaries/${ant_basename}-bin.tar.gz"

  exec {
    'Download maven':
      command => "/usr/bin/curl ${maven_url} | /bin/tar xzv",
      creates => "/opt/${maven_basename}",
      cwd     => '/opt',
      require => Package['curl'],
      ;
    'Download ant':
      command => "/usr/bin/curl ${ant_url} | /bin/tar xzv",
      creates => "/opt/${ant_basename}",
      cwd     => '/opt',
      require => Package['curl'],
      ;
    'source maven bin':
      command => "/bin/echo '[[ -f /etc/profile.d/maven.sh ]] && source /etc/profile.d/maven.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep maven.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
    'source ant bin':
      command => "/bin/echo '[[ -f /etc/profile.d/ant.sh ]] && source /etc/profile.d/ant.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep ant.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  file {
    '/etc/profile.d/maven.sh':
      source => 'puppet:///modules/baseline/maven.sh'
      ;
    '/etc/profile.d/ant.sh':
      source => 'puppet:///modules/baseline/ant.sh'
      ;
    '/opt/maven':
      ensure  => 'link',
      target  => "/opt/${maven_basename}",
      require => Exec['Download maven'],
      ;
    '/opt/ant':
      ensure  => 'link',
      target  => "/opt/${ant_basename}",
      require => Exec['Download ant'],
      ;
  }
}
