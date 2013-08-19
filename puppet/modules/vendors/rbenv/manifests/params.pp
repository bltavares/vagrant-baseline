# == Class: rbenv::params
#
# === Parameters
#
# [$repo_path]
#   The GitHub repository used to install rbenv.
#   Default: 'git://github.com/sstephenson/rbenv.git'
#
# [$install_dir]
#   This is set when you declare the rbenv class. There is no
#   need to overrite it when calling the rbenv::gem define.
#   Default: '/usr/local/rbenv'
#
# [$owner]
#   This is set when you declare the rbenv class. There is no
#   need to overrite it when calling the rbenv::gem define.
#   Default: 'root'
#
# [$group]
#   This is set when you declare the rbenv class. There is no
#   need to overrite it when calling the rbenv::gem define.
#   Default: 'admin'
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
class rbenv::params {
  $repo_path   = 'git://github.com/sstephenson/rbenv.git'
  $install_dir = '/usr/local/rbenv'
  $owner       = 'root'
  $group       = 'adm'
}
