# Class: java7
#
# This module manages Oracle Java7
# Parameters: none
# Requires:
#  apt
# Sample Usage:
#  include java7
class java7 {
  case $::operatingsystem {
    debian: {
      include apt
      
      apt::source { 'webupd8team': 
        location          => "http://ppa.launchpad.net/webupd8team/java/ubuntu",
        release           => "precise",
        repos             => "main",
        key               => "EEA14886",
        key_server        => "keyserver.ubuntu.com",
        include_src       => true
      }
      package { 'oracle-java7-installer':
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Source['webupd8team'],
                          File['/tmp/java.preseed']
                        ],
      }
   }
   ubuntu: {
     include apt

      apt::ppa { 'ppa:webupd8team/java': }
      package { 'oracle-java7-installer':
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Ppa['ppa:webupd8team/java'],
                          File['/tmp/java.preseed']
                        ],
      }
   }
   default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
 }

  case $::operatingsystem {
    debian, ubuntu: {
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/java7/java.preseed',
        mode   => '0600',
        backup => false,
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
