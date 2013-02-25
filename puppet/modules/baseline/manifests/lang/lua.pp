class baseline::lang::lua {

  include gcc
  include baseline::checkinstall
  include apt::update

  $luarocks_basename = 'luarocks-2.0.12'
  $luarocks_tarball = "${luarocks_basename}.tar.gz"
  $luarocks_url = "http://luarocks.org/releases/${luarocks_tarball}"

  package { ['lua5.2', 'lua5.2-dev']:
    ensure  => 'latest',
    require => [Class[apt::update], Class[gcc], Class[baseline::checkinstall]],
  }

  exec {
    'download luarocks':
      command => "/usr/bin/wget ${luarocks_url}",
      creates => "/opt/${luarocks_tarball}",
      cwd     => '/opt',
      ;

    'unpack luarocks':
      command => "/bin/tar xf ${luarocks_tarball}",
      creates => "/opt/${luarocks_basename}",
      cwd     => '/opt',
      require => Exec['download luarocks'],
      ;

    'configure and compile luarocks':
      command => "/opt/${luarocks_basename}/configure --with-lua-include=/usr/include/lua5.2 && make",
      creates => "/opt/${luarocks_basename}/config.unix",
      cwd     => "/opt/${luarocks_basename}",
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      require => [Package['lua5.2'], Package['lua5.2-dev'], Exec['unpack luarocks']],
      ;

    'install luarocks':
      command => '/usr/bin/checkinstall -D',
      creates => '/usr/local/bin/luarocks',
      cwd     => "/opt/${luarocks_basename}",
      require => Exec['configure and compile luarocks'],
      ;
  }

}
