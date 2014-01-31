Baseline 1.1.0

* Add `docker` environment
* Updated `apt` and `stdlib` puppet modules
* Change base image (first run will require a big download)
* Update Puppet version on base image
* Update IO instructions to not break as easilly anymore
* Update Mongo instructions

Baseline 1.0.8

* Bump `elixir` to 0.11.2
* Bump `go` to 1.2.0
* Bump `rust` to 0.8.1
* Bump `redis` to 2.8.2
* Bump `groovy` to 2.2.1
* Bump `zeromq` to 4.0.3
* Bump `scala` to 2.10.3
* Bump `sbt` to 0.13.0
* Bump `gradle` to 1.9
* Update the `provision` command to update the $PATH information after finishing
* Make Puppet provisioning compatible with Vagrant 1.4.0

Baseline 1.0.7

* Bump ruby to 2.0.0-p353
* Bump ruby193 to 1.9.3-p484

Baseline 1.0.6

* Fix maven download url

Baseline 1.0.5

* Add cabal binstub folder to the PATH

Baseline 1.0.4

* Add racket to the environment options

Baseline 1.0.3

* Fix baseline configurations for zsh. Now zsh should have the provision command if the user later decide to change using the chsh command in the box

Baseline 1.0.2.1

* Update the box url to point to the official puppet box in case you dont have the file. It shouldn't affect anyone that is already using a box.

Baseline 1.0.2

* Introduce SML/NJ as a enviroment

Baseline 1.0.1

* Java environment comes with ant and maven now
* Introduce Gradle as a environment option
* Introduce Groovy as a environment option
* Add ctags for all environments

Baseline 1.0.0

* Started to generate the changelog. It include all the previous revisions.
