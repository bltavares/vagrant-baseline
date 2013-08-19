# puppet-rbenv

## Description
This Puppet module will install and manage rbenv on Ubuntu. Additionally,
you can install rbenv plugins and ruby gems.

## Installation

`puppet module install --modulepath /path/to/puppet/modules jdowning-rbenv`

## Usage
To use this module, you must declare it in your manifest like so:

    class { 'rbenv': }

If you wish to install rbenv somewhere other than the default
(`/usr/local/rbenv`), you can do so by declaring the `install_dir`:

    class { 'rbenv': install_dir => '/opt/rbenv' }

The class will merely setup rbenv on your host. If you wish to install
plugins or gems, you will have to add those declarations to your manifests
as well.

## Plugins
Plugins can be installed from GitHub using the following definiton:

    rbenv::plugin { 'github_user/github_repo': }

### Installing and using ruby-build

Ruby requires additional packages to operate properly. On a Ubuntu 12.04 (or higher), you should ensure the following packages are installed:  

    sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev \
      curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 \
      libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool

To install rubies you will need the [ruby-build](https://github.com/sstephenson/ruby-build) plugin 
from @sstephenson. Once installed, you can install most any Ruby. Additionally,
you can set the ruby to be the global interpreter.

    rbenv::plugin { 'sstephenson/ruby-build': }->
    rbenv::build { '2.0.0-p195': global => true }

## Gems
Gems can be installed too! You *must* specify the `ruby_version` you want to
install for.

    rbenv::gem { 'thor': ruby_version => '2.0.0-p195' }

## Requirements
You will need to install the `git` package. If you plan on using `rbenv::build`, then you will also need the `build-essential` package.

## Example
site.pp

    package { 'build-essential': }
    class { 'rbenv': }->rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
    rbenv::build { '2.0.0-p195': global => true }
    rbenv::gem { 'thor': ruby_version   => '2.0.0-p195' }

## Testing

In order to successfully run `vagrant up`, this repository directory
must be called `rbenv`, not `puppet-rbenv`.

    $ git clone https://github.com/justindowning/puppet-rbenv rbenv
    $ cd rbenv
    $ vagrant up
