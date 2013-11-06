class baseline::lang::haskell {

  $baseline_user = hiera('baseline_user')

  file {
    '/etc/profile.d/cabal.sh':
      source => 'puppet:///modules/baseline/cabal.sh',
      ;
  }

  exec {
    'source cabal in zshenv':
      command => "/bin/echo '[[ -f /etc/profile.d/cabal.sh ]] && source /etc/profile.d/cabal.sh' >> /home/${baseline_user}/.zshenv",
      unless  => "/bin/grep cabal.sh /home/${baseline_user}/.zshenv 2> /dev/null",
      ;
  }

  package { 'haskell-platform':
    ensure  => 'latest',
  }

}
