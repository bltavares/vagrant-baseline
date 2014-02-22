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
  - [Working with multiple VMs](#working-with-multiple-vms)
  - [Debugging](#debugging)

### Requirements

* vagrant (which means ruby and VirtualBox)
* Internet connection

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
| clojure    | lein latest stable version          | includes java role                        |
| docker     | latest from docker.io               |                                           |
| elixir     | 0.11.2                              | includes latest erlang                    |
| erlang     | latest from erlang-solutions.com    |                                           |
| go         | 1.2.0                               |                                           |
| gradle     | 1.9                                 | Includes java role                        |
| groovy     | 2.2.1                               | Includes java role                        |
| haskell    | haskell-platform from ubuntu's repo |                                           |
| io         | Latest io deb from io website       |                                           |
| java       | 7 + maven 3.1.1 + ant 1.9.3         |                                           |
| lua        | 5.2 + luarocks                      |                                           |
| mongo      | latest from 10\_gen repo            | *port:* 27017                             |
| nodejs     | latest from ppa:chris.lea           |                                           |
| postgresql | 9.3 + devel package                 | *username:* postgres *password:* postgres |
| prolog     | latest from ppa:swi-prolog/stable   |                                           |
| python     | 2.7 + pip and virtualenv            |                                           |
| rabbitmq   | latest from official apt repo       | *port:* 5672                              |
| racket     | 5.02 (January 2014)                 |                                           |
| redis      | from ppa:chris.lea                  | *port:* 6379                              |
| ruby       | chruby + ruby 2.0                   |                                           |
| ruby193    | chruby + ruby 1.9.3                 |                                           |
| rust       | 0.8                                 |                                           |
| scala      | 2.10.3 + sbt 0.13.0                 | Includes java role                        |
| sml        | smlnj 110.76                        |                                           |
| tools      | editors, version control, and others|                                           |
| zeromq     | 4.0.3                               |                                           |

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

### Debugging

When building the machine, a verbose output can help. In those cases we provide the `DEBUG` variable to increase the output.

```bash
DEBUG=1 host_name=redis vagrant up
```
