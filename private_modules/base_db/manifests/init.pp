# This class is used to setup any databases - in this example it's postgresql
class base_db(
  $postgresql_roles     = {},
  $postgresql_databases = {},
  $postgresql_version   = '9.6',
  $postgres_password    = undef,
  $perform_backup       = undef,
  $backup_dir           = '/var/db_backups/',
) {
  class { 'base_db::postgresql':
    postgres_roles     => $postgresql_roles,
    postgres_databases => $postgresql_databases,
    postgres_version   => $postgresql_version,
    postgres_password  => $postgres_password,
  }

  if $perform_backup {
    class { 'base_db::backup':
      postgres_password => $postgres_password,
      backup_dir        => $backup_dir,
      require           => Class['base_db::postgresql'],
    }
  }
}
