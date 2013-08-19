# == Define: rbenv::gem
#
# === Variable
#
# [$install_dir]
#   This is set when you declare the rbenv class. There is no
#   need to overrite it when calling the rbenv::gem define.
#   Default: $rbenv::install_dir
#   This variable is required.
#
# [$ruby_version]
#   The ruby version under which the gem will be installed.
#   Default: undefined
#   This variable is required.
#
# === Examples
#
# rbenv::gem { 'thor': ruby_version => '2.0.0-p195' }
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
define rbenv::gem(
  $install_dir  = $rbenv::install_dir,
  $ruby_version = undef,
) {
  require rbenv

  exec { "gem-install-${name}":
    command => "${install_dir}/versions/${ruby_version}/bin/gem install ${name}",
    onlyif  => "/usr/bin/test -d ${install_dir}/versions/${ruby_version}",
    unless  => "${install_dir}/versions/${ruby_version}/bin/gem list | grep ${name}",
  }~>
  exec { "rbenv-rehash-${name}":
    command     => "${install_dir}/bin/rbenv rehash",
    refreshonly => true,
  }
}
