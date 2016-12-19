class { 'base':
  users        => hiera('users', {}),
  ssh_keys     => hiera('ssh_keys', {}),
  # # Uncomment the following line if you are provisioning a Vagrant
  # # box for development and want more than ports 80 and 443 open
  has_firewall => false,
  rails_env    => hiera('default_rails_env', 'development'),
}

class { 'base_db':
  postgresql_roles     => hiera('postgresql_roles', {}),
  postgresql_databases => hiera('postgresql_databases', {}),
  require              => Class['base']
}

class { 'redis': }

class { 'base_app':
  rubies              => hiera('rubies', '2.3.1'),
  deployer            => 'vagrant',
  deployers_group     => 'vagrant',
  require             => Class['base'],
  default_ruby        => hiera('default_ruby', '2.3.1'),
  additional_packages => hiera('additional_packages', []),
  purge_packages      => hiera('purge_packages', []),
}
