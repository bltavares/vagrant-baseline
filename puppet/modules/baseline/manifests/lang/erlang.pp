class baseline::lang::erlang( $version = 'latest') { 

  apt::source { 'erlang-solutions':
    location    => 'http://binaries.erlang-solutions.com/debian',
    release     => 'precise',
    repos       => 'contrib',
    key         => 'D208507CA14F4FCA',
    key_source  => 'http://binaries.erlang-solutions.com/debian/erlang_solutions.asc',
    include_src => false,
  }

  package { 'esl-erlang':
    ensure  => $version,
    require => Apt::Source['erlang-solutions'],
  }

}
