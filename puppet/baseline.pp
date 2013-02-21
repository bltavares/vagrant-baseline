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
    include baseline::buildessential
    class { 'rbenv': }
    rbenv::plugin { 'sstephenson/ruby-build': }-> rbenv::build { '1.9.3-p385': global => true }
  }

  if $hostname =~ /nodejs/ {
    include nodejs
  }

  include baseline
}
