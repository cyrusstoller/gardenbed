# This class sets up automatic database backups
class base_db::backup(
  $weeks_to_keep       = '3',
  $days_to_keep        = '7',
  $day_of_week_to_keep = '5',
  $base_backup_dir     = '/home/postgres',
) {
  $backup_dir = "${base_backup_dir}/backup"

  file { $base_backup_dir:
    ensure => directory,
    owner  => 'postgres',
    mode   => '0744',
  }

  file { "${base_backup_dir}/pg_backup.config":
    ensure  => present,
    content => template('base_db/pg_backup.config.erb'),
    owner   => 'postgres',
    mode    => '0744',
  }

  file { "${base_backup_dir}/pg_backup_rotated.sh":
    ensure  => present,
    content => template('base_db/pg_backup_rotated.sh.erb'),
    owner   => 'postgres',
    mode    => '0744',
  }

  cron { 'postgres_backups':
    ensure  => present,
    command => "${base_backup_dir}/pg_backup_rotated.sh >> ${base_backup_dir}/logfile",
    user    => 'postgres',
    hour    => '4',
  }
}