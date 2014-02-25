class { 'base':
  users        => hiera('users', {}),
  ssh_keys     => hiera('ssh_keys', {}),
  # # Uncomment the following line if you are provisioning a Vagrant
  # # box for development and want more than ports 80 and 443 open
  has_firewall => false,
}

class { 'base_db':
  postgresql_roles     => hiera('postgresql_roles', {}),
  postgresql_databases => hiera('postgresql_databases', {}),
  require              => Class['base']
}

class { 'base_app':
  rubies              => hiera('rubies', '2.0.0-p451'),
  deployer            => 'vagrant',
  deployers_group     => 'vagrant',
  require             => Class['base'],
  default_ruby        => hiera('default_ruby', '2.0.0-p451'),
  additional_packages => hiera('additional_packages', []),
  purge_packages      => hiera('purge_packages', []),
}