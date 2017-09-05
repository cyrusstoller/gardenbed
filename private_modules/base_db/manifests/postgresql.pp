# This class sets up the necessary libraries for the postgresql installation
class base_db::postgresql (
  $postgres_roles     = {},
  $postgres_databases = {},
  $postgres_version   = '9.6',
  $postgres_encoding  = 'UTF8',
  $postgres_locale    = 'en_US.UTF-8',
  $postgres_password  = undef,
) {
  file { '/etc/profile.d/lang.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('base_db/lang.sh.erb'),
  }
  -> class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $postgres_version,
    encoding            => $postgres_encoding,
    locale              => $postgres_locale,
  }
  -> class { '::postgresql::server':
    encoding          => $postgres_encoding,
    locale            => $postgres_locale,
    postgres_password => $postgres_password,
  }
  class { '::postgresql::lib::devel': }

  class { 'base_db::postgresql::roles':
    postgres_roles => $postgres_roles
  }
  -> class { 'base_db::postgresql::databases':
    postgres_databases => $postgres_databases
  }

  -> postgresql_psql { 'removing template1 as the default':
    command => template('base_db/remove_template1.sql'),
  }
  -> postgresql_psql { 'dropping template1':
    command => 'DROP DATABASE template1;'
  }
  -> postgresql_psql { "ensure locale = '${postgres_locale}' of template1":
    command => template('base_db/template1.sql.erb'),
  }
  -> postgresql_psql { 'set template 1 as the default':
    command => template('base_db/set_template1.sql'),
  }
  -> postgresql_psql { 'freeze vacuum':
    command => 'VACUUM FREEZE;'
  }
}
