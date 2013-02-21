class avahi::package() {

  case $::operatingsystem {
    centos,fedora,rhel,redhat: {
      class { 'avahi::package::redhat': }
    }
    debian,ubuntu: {
      class { 'avahi::package::debian': }
    }
  }  
}
