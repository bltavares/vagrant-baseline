# Vagrant Baseline
## Core: Dev sandbox with batteries included
---

### Check [Baseline](https://github.com/bltavares/baseline) for command-line support

The idea is to provide a simple dev box with tools.

Sometimes you want to play with a project, which leads you to install a lot of stuff on your computer and the filesystem gets messy.
Your computer turn out to be slow booting up, because it is loading a database that you never use.
Maybe you want to try out a language but it requires you to install all the libraries and compilers.

Now you can mess up all the files in your dev box, and discard when you think it is to messy.

### Table of contents
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Current environments](#current-environments)
  - [Extending an already booted box](#extending-an-already-booted-box)
  - [Using your own dotfiles](#using-your-own-dotfiles)
  - [Setting ZSH as the default shell](#setting-zsh-as-the-default-shell)
  - [Working with multiple VMs](#working-with-multiple-vms)
  - [Extending with your own puppet scripts](#extending-with-your-own-puppet-scripts)
  - [Debugging](#debugging)

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

Check [Baseline](https://github.com/bltavares/baseline) for command line commands

### Current environments
You can combine any of those names on the provision\_name, but it *must* be a valid hostname

| Name       | Provides                            | Extra information                         |
| ---        | ---                                 | ---                                       |
| clojure    | lein latest stable version          | includes java 7                           |
| couchdb    | 1.3.1 + erlang R15B                 | *port:* 5984 *listen on:* 127.0.0.1       |
| docker     | latest from docker.io               |                                           |
| dots       | setup dot files                     |                                           |
| elixir     | 0.11.2                              | includes latest erlang                    |
| erlang     | latest from erlang-solutions.com    |                                           |
| go         | 1.2.0                               |                                           |
| gradle     | 1.9                                 |                                           |
| groovy     | 2.2.1                               |                                           |
| haskell    | haskell-platform from ubuntu's repo |                                           |
| io         | Latest io deb from io website       |                                           |
| java       | 7 + maven 3.1.1 + ant 1.9.2         |                                           |
| lua        | 5.2 + luarocks                      |                                           |
| mongo      | latest from 10\_gen repo            | *port:* 27017                             |
| nodejs     | latest from ppa:chris.lea           |                                           |
| postgresql | 9.2 + devel package                 | *username:* postgres *password:* postgres |
| prolog     | swipl 6.2.6                         |                                           |
| python     | 2.7 + pip and virtualenv            |                                           |
| rabbitmq   | latest from official apt repo       | *port:* 5672                              |
| racket     | 5.3.6 (August 2013)                 |                                           |
| redis      | 2.8.2 (from ppa:chris.lea)          | *port:* 6379                              |
| ruby       | rbenv + ruby 2.0                    |                                           |
| ruby193    | rbenv + ruby 1.9.3                  |                                           |
| rust       | 0.8                                 |                                           |
| scala      | 2.10.3 + sbt 0.13.0                 | includes java 7                           |
| sml        | smlnj 110.76                        |                                           |
| zeromq     | 4.0.3                               |                                           |


### Extending an already booted box

Baseline commes with a command to provision more of the supported environment from inside the box.
Use the `provision` command to do so.

```bash
vagrant ssh
vagrant@vagrant $ provision redis lua
```

### Using your own dotfiles

By default the manifest privison my own dotfiles (http://github.com/bltavares/dot-files) when you ask for it. You can change `puppet/config.yaml` to point to your dotfiles and have it loaded up.

```bash
baseline up redis dots
```

There a minor considerations to use your own dotfiles:

* It must be a git repo
* It must contain an excutable file called install.sh in the root of your repo. It will be called to setup your dotfiles configurations.
* To make sure it doesn't run everytime you turn your vagrant on, add this to the end of the file:

```bash
touch $HOME/.baseline_dotfiles
```
    
After making sure you have all the requirements in place, change on the file _puppet/config.yaml_ to point to your repo.

### Setting ZSH as the default shell

To set zsh as the default shell for your user, change the option under _puppet/config.yaml_.

### Working with multiple VMs

Vagrant's configuration allows you to either use a single vm environments or use multiple.
Sometimes you want to try out some other stack while still keeping the current one you are using. Or test networking with different stacks.
Toggling the enviroment variable use_default_box, baseline will allow you to bootstrap multiple machines or a single machine.

```bash
host_name=dots-nodejs use_default_box=false vagrant up
host_name=dots-nodejs use_default_box=false vagrant ssh
host_name=mongo use_default_box=false vagrant up
host_name=mongo use_default_box=false vagrant destroy
host_name=dots-nodejs use_default_box=false vagrant destroy
```


### Extending with your own puppet scripts

Sometimes you will want to try out some different modules that are not currently in the project, or will want to set up a webserver for the project you are writing and have it configured and deployed with your project.
Or maybe you just want to have some packages installed, or removed.

You can achieve that extending the project using the _puppet/custom_ folder. There is an example file to guide you in the path to extend your vagrant machine.

### Debugging

When building puppet scripts, a verbose output can help. In those cases we provide the `DEBUG` variable to increase the output, show debug messages and create dependency graphs

```bash
DEBUG=1 host_name=redis vagrant up
```
