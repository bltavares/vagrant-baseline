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


At first, the setup will download the required packages and it will take a while depending of your connection.
It builds a cache on your local machine, under ~/.vagrant.d/cache/apt/precise, so on the next build the bootstrap time becomes much smaller.

The cache is only directed to the .deb packages. It still compiles some packages from scratch. (e.g: ruby, redis)

### Usage

    provision_name=ruby-nodejs vagrant up

To extend a machine with another env:

    provision_name=java vagrant reload

### Current environments
You can combine any of those names on the provision\_name, but it *must* be a valid hostname

* ruby (rbenv + ruby 1.9.3)
* nodejs (latest from ppa:chris.lea)
* java (7)
* redis (2.6.10 port 6379)
* mongo (latest from 10\_gen ppa port 27017)
