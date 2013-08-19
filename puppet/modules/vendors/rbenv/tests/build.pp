package { ['git', 'build-essential']: ensure => installed }->
class { 'rbenv': }->
rbenv::plugin { 'sstephenson/ruby-build': }->
rbenv::build { '1.9.3-p385': global => true }
