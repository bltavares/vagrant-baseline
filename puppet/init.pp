node default {

  import 'custom/**.pp'
  include baseline

  if $hostname =~ /\bjava\b/ {
    include baseline::lang::java
  }

  if $hostname =~ /\bgroovy\b/ {
    include baseline::lang::java
    include baseline::lang::groovy
  }

  if $hostname =~ /\bgradle\b/ {
    include baseline::lang::java
    include baseline::gradle
  }

  if $hostname =~ /\bscala\b/ {
    include baseline::lang::java
    include baseline::lang::scala
  }

  if $hostname =~ /\bclojure\b/ {
    include baseline::lang::java
    include baseline::lein
  }

  if $hostname =~ /\bruby\b/  {
    baseline::lang::ruby { '2.0.0-p353': }
  }

  if $hostname =~ /\bruby193\b/  {
    baseline::lang::ruby { '1.9.3-p484': }
  }

  if $hostname =~ /\bnodejs\b/ {
    include baseline::lang::nodejs
  }

  if $hostname =~ /\blua\b/ {
    include baseline::lang::lua
  }

  if $hostname =~ /\bpython\b/ {
    include baseline::lang::python
  }

  if $hostname =~ /\bhaskell\b/ {
    include baseline::lang::haskell
  }

  if $hostname =~ /\bio\b/ {
    include baseline::lang::io
  }

  if $hostname =~ /\bprolog\b/ {
    include baseline::lang::prolog
  }

  if $hostname =~ /\bgo\b/ {
    include baseline::lang::go
  }

  if $hostname =~ /\brust\b/ {
    include baseline::lang::rust
  }

  if $hostname =~ /\bredis\b/ {
    class { 'redis':
      version => '2.6.10',
    }
  }

  if $hostname =~ /\bmongo\b/ {
    class { 'mongodb':
      enable_10gen => true,
    }
  }

  if $hostname =~ /\bpostgresql\b/ {
    include baseline::postgres
  }

  if $hostname =~ /\bsml\b/ {
    include baseline::lang::sml
  }

  if $hostname =~ /\bracket\b/ {
    include baseline::lang::racket
  }

  if $hostname =~ /\berlang\b/ {
    include baseline::lang::erlang
  }

  if $hostname =~ /\belixir\b/ {
    include baseline::lang::erlang
    include baseline::lang::elixir
  }

  if $hostname =~ /\bcouchdb\b/ {
    class { 'baseline::lang::erlang': version => '1:15.b.3-2~ubuntu~precise' } -> class { 'baseline::couchdb': }
  }

  if $hostname =~ /\brabbitmq\b/ {
    class { 'baseline::lang::erlang': } -> class { '::rabbitmq': erlang_manage => false }
  }
  if $hostname =~ /\bzeromq\b/ {
    include baseline::zeromq
  }

  if $hostname =~ /\bdots\b/ {
    include baseline::dotfiles
  }

}
