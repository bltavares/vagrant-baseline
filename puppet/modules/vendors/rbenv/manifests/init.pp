# == Class: rbenv
#
# Full description of class rbenv here.
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
#  class { rbenv: }
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
# === Copyright
#
# Copyright 2013 Justin Downing
#
class rbenv {

  require git

  include rbenv::params

  exec { 'git-clone-rbenv':
    command   => "/usr/bin/git clone \
                  ${rbenv::params::repo_path} \
                  ${rbenv::params::install_dir}",
    creates   => $rbenv::params::install_dir
  }

  file { [
    $rbenv::params::install_dir,
    "${rbenv::params::install_dir}/plugins",
    "${rbenv::params::install_dir}/shims",
    "${rbenv::params::install_dir}/versions"
  ]:
    ensure    => directory,
    owner     => 'root',
    group     => 'admin',
    mode      => '0775',
  }

  file { '/etc/profile.d/rbenv.sh':
    ensure    => file,
    content   => template('rbenv/rbenv.sh'),
    mode      => '0775'
  }

  Exec['git-clone-rbenv'] -> File['/usr/local/rbenv']

}
