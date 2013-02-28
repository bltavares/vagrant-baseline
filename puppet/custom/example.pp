# This is an example of how to add custom configurations on your node
#
# notify { 'Hello from an extension': }
#
# You can use the vendors folder to download manifests from Puppet Forge
# and it will be loaded on your module path already
# You can use the command line to download it from the forge
#
# From the baseline root dir, run:
#
#puppet module install rcoleman/mysql --modulepath puppet/custom/vendors
#
# And just include it later
#
# include  mysql
#
# All puppet commands are available for you
#
# if $hostname ~= /php/ {
#  include php
# }
#
#
# Using custom classes
#
# If you want to write your own class, just write it under any file and include it normaly. e.g.
#
# file location custom/custom_class.pp
# --------
# class custom_class {
#  file { '/home/vagrant/hello-world':
#    content => 'Hello world!',
#    ;
#  }
# }
#---------
#
# Then include it on this file
#
# include custom_class

