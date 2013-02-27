# == Class: rbenv::params
#
class rbenv::params {
  $repo_path       = 'git://github.com/sstephenson/rbenv.git'
  $install_dir     = '/usr/local/rbenv'
}
