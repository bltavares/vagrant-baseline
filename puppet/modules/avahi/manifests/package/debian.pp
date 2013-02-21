class avahi::package::debian {

  $packages = ['avahi-daemon','libnss-mdns','avahi-utils']

  package { $packages:
    ensure => present,
  }

}
