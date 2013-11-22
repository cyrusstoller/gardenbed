# This class sets up the necessary libraries for the postgresql installation
class base_db::postgresql (
  $postgres_roles     = {},
  $postgres_databases = {},
  $postgres_version   = '9.3',
) {
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => $postgres_version,
    encoding            => 'UTF8',
    locale              => 'en_US.UTF-8'
  }
  ->
  class { '::postgresql::server':
    version => $postgres_version,
  }
  class { '::postgresql::lib::devel': }

  class { 'base_db::postgresql::roles':
    postgres_roles => $postgres_roles
  }->
  class { 'base_db::postgresql::databases':
    postgres_databases => $postgres_databases
  }
}