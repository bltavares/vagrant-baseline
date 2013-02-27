# Baseline
## Dev box with batteries included

The idea is to provide a simple dev box with tools.

Sometimes you want to play with a project, which leads you to install a lot of stuff on your computer and the filesystem gets messy.
Your computer turn out to be slow booting up, because it is loading a database that you never use.
Maybe you want to try out a language but it requires you to install all the libraries and compilers.

Now you can mess up all the files in your dev box, and discard when you think it is to messy.



### Table of contents
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Current environments](#current-environments)
  - [Experienced usage: Running setup using puppet apply](#experienced-usage-running-setup-using-puppet-apply)
  - [Using your own dotfiles](#using-your-own-dotfiles)
  - [Skip setting ZSH as the default shell](#skip-setting-ZSH-as-the-default-shell)

### Requirements

* vagrant (which means ruby and VirtualBox)
* Internet connection
* An updated base box with the puppet 3.1.0

If you don't know what a base box is, relax. Vagrant will download one for you on the first time you run the commands. It is around 350Mb.
If you don't know how to update a base box, take a look on the _Vagrantfile_. There is a link were you can find a updated box.

At first, the setup will download the required packages and it will take a while depending of your connection.
It builds a cache on your local machine, under ~/.vagrant.d/cache/apt/precise, so on the next build the bootstrap time becomes much smaller.

The cache is only directed to the .deb packages. It still compiles some packages from scratch. (e.g: ruby, redis)

### Installation

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

    host_name=ruby-nodejs vagrant up

To extend a machine with another env:

    host_name=java vagrant reload

### Current environments
You can combine any of those names on the provision\_name, but it *must* be a valid hostname

| Name     | Provides                            | Extra information                         |
| ---      | ---                                 | ---                                       |
| clojure  | lein latest stable version          |                                           |
| erlang   | latest from erlang-solutions.com    |                                           |
| haskell  | haskell-platform from ubuntu's repo |                                           |
| io       | Latest io deb from io website       |                                           |
| java     | 7                                   |                                           |
| lua      | 5.2 + luarocks                      |                                           |
| mongo    | latest from 10\_gen repo            | *port:* 27017                             |
| nodejs   | latest from ppa:chris.lea           |                                           |
| nodots   | skip setup of dot files             |                                           |
| postgres | 9.2                                 | *username:* postgres *password:* postgres |
| python   | 2.7 + pip and virtualenv            |                                           |
| redis    | 2.6.10                              | *port:* 6379                              |
| ruby     | rbenv + ruby 1.9.3                  |                                           |
| scala    | 2.10.0 + sbt 0.12.2                 |                                           |

By default, it load up my dot files (http://github.com/bltavares/dot-files). To skip it, combine on the provision\_name  _nodots_ e.g.:

    host_name=nodots-redis vagrant up

### Using your own dotfiles

By default the manifest privison my own dotfiles (http://github.com/bltavares/dot-files). You can change to point to your dotfiles and have it loaded up.
There a minor considerations to use your own dotfiles:

* It must be a git repo
* It must contain an excutable file called install.sh in the root of your repo. It will be called to setup your dotfiles configurations.
* To make sure it doesn't run everytime you turn your vagrant on, add this to the end of the file:

    touch $HOME/.baseline_dotfiles
    
After making sure you have all the requirements in place, change on the file _puppet/config.yaml_ to point to your repo.


### Skip setting ZSH as the default shell

To skip setting zsh as the default shell for your user, change the option under _puppet/config.yaml_.

---

### Experienced usage: Running setup using _puppet apply_

The bootstrap relies on the _$hostname_ property set up by puppet. You might not want to change the hostname of your running computer, for example, and might want to provision your computer with those scripts.

You can override the _$hostname_ property that puppet defines before running your command. e.g

    # cd to the puppet dir
    cd baseline/puppet
    FACTER_hostname=redis puppet apply --confdir . init.pp

