# This class sets up automatic database backups
class base_db::backup(
  $weeks_to_keep       = '3',
  $days_to_keep        = '7',
  $day_of_week_to_keep = '5',
  $base_backup_dir     = '/home/postgres',
  $postgres_password   = undef,
) {

  $backup_dir        = "${base_backup_dir}/backup"
  $logfile           = "${base_backup_dir}/pg_backup.log"
  $base_cron_command = "${base_backup_dir}/pg_backup_rotated.sh >> ${logfile}"

  file { $base_backup_dir:
    ensure => directory,
    owner  => 'postgres',
    mode   => '0744',
  }

  if $postgres_password {
    $pgpass_file  = "${base_backup_dir}/.pgpass"
    $cron_command = "PGPASSFILE=${pgpass_file} ${base_cron_command}"

    file { $pgpass_file:
      ensure  => present,
      content => "*:*:*:postgres:${postgres_password}",
      owner   => 'postgres',
      mode    => '0600',
    }
  } else {
    $cron_command = $base_cron_command
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

  file { '/etc/logrotate.d/postgres_db_backup':
    ensure  => present,
    content => template('base_db/postgres_db_backup.erb'),
    mode    => '0644',
  }

  cron { 'postgres_backups':
    ensure  => present,
    command => $cron_command,
    user    => 'postgres',
    hour    => '4',
  }
}