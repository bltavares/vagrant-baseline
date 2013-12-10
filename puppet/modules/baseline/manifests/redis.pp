class baseline::redis {

  include apt

  apt::ppa { 'ppa:chris-lea/redis-server': }

  package { 'redis-server':
    ensure  => 'latest',
    require => Apt::Ppa['ppa:chris-lea/redis-server'],
    ;
  }

  service { 'redis-server':
    enable  => true,
    ensure  => 'running',
    require => Package['redis-server'],
    ;
  }

  file { '/etc/redis/redis.conf':
    ensure  => 'present',
    notify  => Service['redis-server'],
    require => Package['redis-server'],
    source  => 'puppet:///modules/baseline/redis.conf',
    ;
  }
}
