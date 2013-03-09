class baseline::lang::python {

  $apt_packages = [
    'python-dev',
    'python-pip',
  ]

  $pip_packages = [
    'pip',
    'virtualenv',
  ]

  package {
    $apt_packages:
      ensure  => 'latest',
      ;
    $pip_packages:
      ensure   => 'latest',
      provider => 'pip',
      require  => Exec['upgrade apt pip'],
      ;
  }

  exec {
    'upgrade apt pip':
      command => '/usr/bin/pip install --upgrade pip',
      creates => '/usr/local/bin/pip',
      onlyif  => '/bin/bash -c "test -e /usr/bin/pip"',
      require => Package['python-pip']
      ;
  }

}
