# Baseline
## Dev box with batteries

The ideia is to provide a simple dev box with tools.

Sometimes you want to play with a project, which leads you to install a lot of stuff on your computer and the filesystem gets messy.
Your computer turn out to be slow booting up, because it is loading a database that you never use.
Maybe you want to try out a language but it requires you to install all the libraries and compilers.

Now you can mess up all the files in your dev box, and discard when you think it is to messy.

## Requirements

* vagrant (Which means ruby and VirtualBox)
* Internet connection
* An updated base box with the puppet 3.1.0

If you don't know what a base box is, relax. Vagrant will download one for you on the first time you run the commands. It is around 350Mb.
If you don't know how to update a base box, take a look on the _Vagrantfile_. There is a link were you can find a updated box.

At first, the setup will download the required packages and it will take a while depending of your connection.
It builds a cache on your local machine, under ~/.vagrant.d/cache/apt/precise, so on the next build the bootstrap time becomes much smaller.

The cache is only directed to the .deb packages. It still compiles some packages from scratch. (e.g: ruby, redis)

## Instalation

First of all, clone the repo:

    git clone https://github.com/bltavares/vagrant-baseline.git baseline
    cd baseline

If you have _bundler_ you can use the _Gemfile_ to install _vagrant_

    bundle install

If you don't have _bundler_ you can install it manually

    gem install vagrant
    #If you have to update
    gem update vagrant

If you are using rbenv don't forget to update the commands database, otherwise it won't find your new _vagrant_

    rbenv rehash

### Usage

    provision_name=ruby-nodejs vagrant up

To extend a machine with another env:

    provision_name=java vagrant reload

### Current environments
You can combine any of those names on the provision\_name, but it *must* be a valid hostname

* ruby (rbenv + ruby 1.9.3)
* nodejs (latest from ppa:chris.lea)
* java (7)
* lua (5.2 + luarocks)
* redis (2.6.10 port 6379)
* mongo (latest from 10\_gen ppa port 27017)
* postgre (9.2 Username: postgres Password: postgres)

By default, it load up my dot files (http://github.com/bltavares/dot-files). To skip it, combine on the provision\_name  _nodots_ e.g.:

    provision_name=nodots-redis vagrant up


