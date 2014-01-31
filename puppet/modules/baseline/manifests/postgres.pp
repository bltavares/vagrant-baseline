class baseline::postgres {

  class{ 'postgresql::globals':
    version               => '9.3',
    manage_package_repo   => true,
  }->
  class { 'postgresql::server':
    ip_mask_allow_all_users    => '0.0.0.0/0',
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    listen_addresses           => '*',
    postgres_password          => 'postgres',
  }->
  class { 'postgresql::lib::devel': }

}
