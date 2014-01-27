class baseline::docker {

  $baseline_user = hiera('baseline_user', 'vagrant')
  $docker_kernel = [
    'linux-headers-generic-lts-raring',
    'linux-image-generic-lts-raring',
    'dkms',
  ]

  apt::source { 'docker.io':
    include_src => false,
    key      => '36A1D7869245C8950F966E92D8576A8BA88D21E9',
    location => 'http://get.docker.io/ubuntu',
    release  => 'docker',
    repos => 'main',
  }

  package {
    $docker_kernel:
      ensure => 'latest',
      ;
    'lxc-docker':
      ensure => 'latest',
      require => [Apt::Source['docker.io'], Package[$docker_kernel]],
      ;
  }

  user { $baseline_user:
    ensure  => 'present',
    groups  => 'docker',
    require => Package['lxc-docker'],
  }

}
