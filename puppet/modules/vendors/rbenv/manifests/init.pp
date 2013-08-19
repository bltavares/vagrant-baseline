# == Class: rbenv
#
# This module manages rbenv on Ubuntu. The default installation directory
# allows rbenv to available for all users and applications.
#
# === Variables
#
# [$install_dir]
#   This is where rbenv will be installed to. If you do not
#   specify this parameter, it will use the default in rbenv::params.
#   Default: $rbenv::params::install_dir
#   This variable is required.
#
# [$owner]
#   This defines who owns the rbenv install directory. If you do not
#   specify this parameter, it will use the default in rbenv::params.
#   Default: $rbenv::params::owner
#   This variable is required.
#
# [$group]
#   This defines the group membership for rbenv. If you do not
#   specify this parameter, it will use the default in rbenv::params.
#   Default: $rbenv::params::group
#   This variable is required.
#
# === Requires
#
# You will need to install the git package on the host system.
#
# === Examples
#
# class { rbenv: }  #Uses the default parameters from rbenv::params
#
# class { rbenv:  #Uses a user-defined installation path
#   install_dir => '/opt/rbenv',
# }
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
# === Copyright
#
# Copyright 2013 Justin Downing
#
class rbenv(
  $install_dir = $rbenv::params::install_dir,
  $owner       = $rbenv::params::owner,
  $group       = $rbenv::params::group
) inherits rbenv::params {

  exec { 'git-clone-rbenv':
    command => "/usr/bin/git clone \
               ${rbenv::params::repo_path} \
               ${install_dir}",
    creates => $install_dir,
    user    => $owner,
  }

  file { [
    $install_dir,
    "${install_dir}/plugins",
    "${install_dir}/shims",
    "${install_dir}/versions"
  ]:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    mode    => '0775',
  }

  file { '/etc/profile.d/rbenv.sh':
    ensure    => file,
    content   => template('rbenv/rbenv.sh'),
    mode      => '0775'
  }

  Exec['git-clone-rbenv'] -> File[$install_dir]

}
