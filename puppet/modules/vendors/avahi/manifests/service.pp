class avahi::service() {

  case $::operatingsystem {
    centos,fedora,rhel,redhat: {
      class { 'avahi::service::redhat': }
    }
    debian,ubuntu: {
    }
  }  

  service { 'avahi-daemon':
    enable => true,
    ensure => running,
  }
}
