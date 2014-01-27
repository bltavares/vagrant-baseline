class baseline::docker {

  $docker_kernel = [
    'linux-image-generic-lts-raring',
    'linux-headers-generic-lts-raring',
    'dkms',
  ]

  package { $docker_kernel:
    ensure => 'latest',
  }

}
