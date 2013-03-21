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
  - [Using your own dotfiles](#using-your-own-dotfiles)
  - [Skip setting ZSH as the default shell](#skip-setting-zsh-as-the-default-shell)
  - [Working with multiple VMs](#working-with-multiple-vms)
  - [Extending with your own puppet scripts](#extending-with-your-own-puppet-scripts)
  - [Using GUI programs](#using-gui-programs)
  - [Experienced usage: Running setup using puppet apply](#experienced-usage-running-setup-using-puppet-apply)
  - [Shortcut to provision your machine](#shortcut-to-provision-your-machine)

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

```bash
git clone https://github.com/bltavares/vagrant-baseline.git baseline
cd baseline
```

If you have _bundler_ you can use the _Gemfile_ to install _vagrant_

```bash
bundle install
```

If you don't have _bundler_ you can install it manually

```bash
gem install vagrant
#If you have to update
gem update vagrant
```

If you are using rbenv don't forget to update the commands database, otherwise it won't find your new _vagrant_

```bash
rbenv rehash
```

### Usage

```bash
host_name=ruby-nodejs vagrant up
```

To extend a machine with another env:

```bash
host_name=java vagrant reload
```

### Current environments
You can combine any of those names on the provision\_name, but it *must* be a valid hostname

| Name     | Provides                            | Extra information                         |
| ---      | ---                                 | ---                                       |
| clojure  | lein latest stable version          | includes java 7                           |
| couchdb  | 1.2.1 + erlang R15B                 | *port:* 5984 *listen on:* 127.0.0.1       |
| elixir   | 0.8.1                               | includes latest erlang                    |
| erlang   | latest from erlang-solutions.com    |                                           |
| go       | 1.0.3                               |                                           |
| haskell  | haskell-platform from ubuntu's repo |                                           |
| io       | Latest io deb from io website       |                                           |
| java     | 7                                   |                                           |
| lua      | 5.2 + luarocks                      |                                           |
| mongo    | latest from 10\_gen repo            | *port:* 27017                             |
| nodejs   | latest from ppa:chris.lea           |                                           |
| nodots   | skip setup of dot files             |                                           |
| postgres | 9.2                                 | *username:* postgres *password:* postgres |
| prolog   | swipl 6.2.6                         |                                           |
| python   | 2.7 + pip and virtualenv            |                                           |
| redis    | 2.6.10                              | *port:* 6379                              |
| ruby     | rbenv + ruby 2.0                    |                                           | 
| rust     | 0.5.1                               |                                           |
| scala    | 2.10.0 + sbt 0.12.2                 | includes java 7                           |

By default, it load up my dot files (http://github.com/bltavares/dot-files). To skip it, combine on the provision\_name  _nodots_ e.g.:

```bash
host_name=nodots-redis vagrant up
```

### Using your own dotfiles

By default the manifest privison my own dotfiles (http://github.com/bltavares/dot-files). You can change to point to your dotfiles and have it loaded up.
There a minor considerations to use your own dotfiles:

* It must be a git repo
* It must contain an excutable file called install.sh in the root of your repo. It will be called to setup your dotfiles configurations.
* To make sure it doesn't run everytime you turn your vagrant on, add this to the end of the file:

```bash
touch $HOME/.baseline_dotfiles
```
    
After making sure you have all the requirements in place, change on the file _puppet/config.yaml_ to point to your repo.


### Skip setting ZSH as the default shell

To skip setting zsh as the default shell for your user, change the option under _puppet/config.yaml_.

### Working with multiple VMs

Vagrant's configuration allows you to either use a single vm environments or use multiple.
Sometimes you want to try out some other stack while still keeping the current one you are using. Or test networking with different stacks.
Toggling the enviroment variable use_default_box, baseline will allow you to bootstrap multiple machines or a single machine.

```bash
host_name=nodejs use_default_box=false vagrant up
host_name=nodejs use_default_box=false vagrant ssh
host_name=nodots-mongo use_default_box=false vagrant up
host_name=nodots-mongo use_default_box=false vagrant destroy
host_name=nodejs use_default_box=false vagrant destroy
```


### Extending with your own puppet scripts

Sometimes you will want to try out some different modules that are not currently in the project, or will want to set up a webserver for the project you are writing and have it configured and deployed with your project.
Or maybe you just want to have some packages installed, or removed.

You can achieve that extending the project using the _puppet/custom_ folder. There is an example file to guide you in the path to extend your vagrant machine.


### Using GUI programs

Ssh allows you to forward the X server to your computer. If you want to use a program with a grafical interface or want to code an app that generates graphics, you can ask `vagrant` to forward it for you.

Just goes with:
```ruby
vagrant ssh -- -X
```

---

### Experienced usage: Running setup using _puppet apply_

The bootstrap relies on the _$hostname_ property set up by puppet. You might not want to change the hostname of your running computer, for example, and might want to provision your computer with those scripts.

You can override the _$hostname_ property that puppet defines before running your command. e.g

```ruby
# cd to the puppet dir
cd baseline/puppet
FACTER_hostname=redis puppet apply --confdir . init.pp
```

### Shortcut to provision your machine

Include the following function on your .bashrc or .zshrc, or just paste it on your terminal to have access to a shortcut to provision your machines.

```bash
provision () {
    PROVISION=$(echo "nodots $@" | tr " " "-" | sed 's/-$//')
    (
        cd ${PUPPET_FILES:-/tmp/vagrant-puppet/manifests}
        sudo FACTER_hostname=$PROVISION puppet apply --confdir . init.pp --verbose --debug
    )
}
```

After that you can run the provision as the following:
```bash
provision lua clojure redis
```

If you had it checked out on another path that is not set by the Vagrantfile, you can customize it as the following:
```bash
export PUPPET_FILES=/path/to/the/configurations
provision scala mongo
```

