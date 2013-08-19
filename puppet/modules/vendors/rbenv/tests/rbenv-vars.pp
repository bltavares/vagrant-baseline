package { 'git': ensure => 'installed' }->
class { 'rbenv': }->
rbenv::plugin { 'sstephenson/rbenv-vars': }
