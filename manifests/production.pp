class { 'base':
  users        => hiera('users', {}),
  ssh_keys     => hiera('ssh_keys', {}),
  # # Uncomment the following line if you are provisioning a Vagrant
  # # box for development and want more than ports 80 and 443 open
  # has_firewall => false,
  rails_env    => hiera('default_rails_env', 'production'),
}

class { 'base_db':
  postgresql_roles     => hiera('postgresql_roles', {}),
  postgresql_databases => hiera('postgresql_databases', {}),
  postgres_password    => hiera('postgres_password', undef),
  require              => Class['base'],
  perform_backup       => true,
}

class { 'base_web':
  require => Class['base']
}

class { 'base_app':
  rubies              => hiera('rubies', '2.0.0-p451'),
  require             => Class['base'],
  default_ruby        => hiera('default_ruby', '2.0.0-p451'),
  additional_packages => hiera('additional_packages', []),
  purge_packages      => hiera('purge_packages', []),
}

$s3_info = hiera('s3', {})

class { 's3cmd':
  user           => $s3_info['user'],
  group          => $s3_info['user'],
  access_key     => $s3_info['access_key'],
  secret_key     => $s3_info['secret_key'],
  gpg_passphrase => $s3_info['gpg_passphrase'],
}

if $s3_info['bucket'] {
  $backup_directories = {
    '/var/db_backups/' => {}
  }
  $backup_defaults = { user => $s3_info['user'], bucket => $s3_info['bucket'] }
  create_resources('s3cmd::backup', $backup_directories, $backup_defaults)
}
