class avahi::service::redhat {

  service { 'messagebus':
    enable => true,
    ensure => running,
    notify => Service['avahi-daemon']
  }

}
