class baseline::postgre {

  class { 'postgresql':
    version               => '9.2',
    manage_package_repo   => true,
    }-> class { 'postgresql::server':
      config_hash => {
        'ip_mask_allow_all_users'    => '0.0.0.0/0',
        'ip_mask_deny_postgres_user' => '0.0.0.0/32',
        'listen_addresses'           => '*',
        'postgres_password'          => 'postgres',
      },
    }

}
