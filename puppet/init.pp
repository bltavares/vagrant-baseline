node default {

  import 'custom/**.pp'
  include baseline

  if $hostname =~ /\bjava\b/ {
    include java7
  }

  if $hostname =~ /\bruby\b/  {
    include baseline::lang::ruby
  }

  if $hostname =~ /\bnodejs\b/ {
    include baseline::lang::nodejs
  }

  if $hostname =~ /\blua\b/ {
    include baseline::lang::lua
  }

  if $hostname =~ /\bclojure\b/ {
    include java7
    include baseline::lein
  }

  if $hostname =~ /\bpython\b/ {
    include baseline::lang::python
  }

  if $hostname =~ /\berlang\b/ {
    include baseline::lang::erlang
  }

  if $hostname =~ /\bhaskell\b/ {
    include baseline::lang::haskell
  }

  if $hostname =~ /\bscala\b/ {
    include java7
    include baseline::lang::scala
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

  if $hostname =~ /\belixir\b/ {
    include baseline::lang::erlang
    include baseline::lang::elixir
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

  if $hostname =~ /\bpostgre\b/ {
    include baseline::postgre
  }

  if $hostname =~ /\bcouchdb\b/ {
    class { 'baseline::lang::erlang': version => '1:15.b.3-2~ubuntu~precise' } -> class { 'baseline::couchdb': }
  }

  if $hostname =~ /\bdots\b/ {
    include baseline::dotfiles
  }

}
