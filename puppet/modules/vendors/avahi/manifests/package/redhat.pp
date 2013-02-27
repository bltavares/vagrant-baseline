class avahi::package::redhat {

  $packages = ['avahi', 'avahi-autoipd', 'avahi-compat-libdns_sd', 'avahi-glib', 'avahi-gobject', 'avahi-tools', 'nss-mdns']
  
  package { $packages:
    ensure => present,
  }

}
