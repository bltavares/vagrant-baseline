node default {

  include apt::update
  class { 'avahi':
        firewall => true,
        require => Class[apt::update],
        ;
  }

  if $hostname =~ /java/ {
    include java7
  }

  if $hostname =~ /ruby/  {
    class { 'gcc': 
      require => Class[apt::update],
    }

    class { 'rbenv': }
    rbenv::plugin { 'sstephenson/ruby-build': }-> rbenv::build { '1.9.3-p385': global => true }

    file {
      '/home/vagrant/.host_specific':
        content => "[[ -f /etc/profile.d/rbenv.sh ]] && source /etc/profile.d/rbenv.sh"
    }
  }

  if $hostname =~ /nodejs/ {
    apt::ppa { "ppa:chris-lea/node.js": }
    class { 'nodejs': 
      require => Apt::Ppa["ppa:chris-lea/node.js"]
    }
  }

  if $hostname =~ /redis/ {
    class { 'redis':
        version => '2.6.10',
    } 
  }

  include baseline
}
