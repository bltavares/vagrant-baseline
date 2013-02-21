class baseline {

  include git
  include apt::update

  $packages = [
    'aptitude',
    'curl',
    'emacs',
    'gawk',
    'meld',
    'mplayer',
    'vim-gnome',
    'vim-gtk',
    'zsh',
  ]

  package {
    $packages:
    ensure => 'latest',
    require => [Class[apt::update], Package['git-core']],
      ;
  }

  Exec { path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', }

  exec {
    'set up default settings':
    command => 'curl https://gist.github.com/bltavares/2706792/raw/post-install.sh | bash',
    cwd     => '/home/vagrant',
    require => [Package['curl'], Package['git-core']],
    user    => 'vagrant',
    ;

  'download dot-files':
    command => 'git clone https://github.com/bltavares/dot-files.git /home/vagrant/dot-files',
    creates => '/home/vagrant/dot-files',
    require => Exec['set up default settings'],
    user    => 'vagrant',
    ;

  'install-dot-files':
    command => 'bash -c "HOME=/home/vagrant ./install.sh"',
    cwd     => '/home/vagrant/dot-files',
    creates => '/home/vagrant/.zshrc',
    require => Exec['download dot-files'],
    user    => 'vagrant',
    ;

  'set shell':
    command => 'chsh -s /bin/zsh vagrant',
    require => Exec['install-dot-files'],
    ;
  }

}
