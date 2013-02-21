## DEFINE
define rbenv::gem ($title=$gem, $ruby_version=undef) {
  require rbenv
  include rbenv::params

  exec { "gem-install-${name}":
    command => "${rbenv::params::install_dir}/versions/${ruby_version}/bin/gem install ${gem}",
    require => Rbenv::Build[$ruby_version],
    onlyif  => "test -d ${rbenv::params::install_dir}/versions/${ruby_version}",
    unless  => "${rbenv::params::install_dir}/versions/${ruby_version}/bin/gem list | grep ${gem}",
  }
}
