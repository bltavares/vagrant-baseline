class baseline::lang::ruby {

  include gcc

  $packages = [
    'libcurl4-openssl-dev',
    'libxml2-dev',
    'libxslt-dev',
    'zlib1g-dev',
  ]
  package {
    $packages:
      ensure    => 'latest',
      ;
  }

  class { 'rbenv': }
  rbenv::plugin { 'sstephenson/ruby-build': }-> rbenv::build { '2.0.0-p247': global => true }

  $baseline_user = hiera('baseline_user','vagrant')
  exec {
    'source rbenv in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/rbenv.sh ]] && source /etc/profile.d/rbenv.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep rbenv.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

}
