class baseline::lang::ruby {

  include apt::update

  class { 'gcc':
    require => Class[apt::update],
  }

  class { 'rbenv': }
  rbenv::plugin { 'sstephenson/ruby-build': }-> rbenv::build { '1.9.3-p385': global => true }

  $baseline_user = hiera('baseline_user','vagrant')
  file {
    "/home/${baseline_user}/.host_specific":
      content => '[[ -f /etc/profile.d/rbenv.sh ]] && source /etc/profile.d/rbenv.sh'
  }

}
