class base_db::postgresql (
  $postgres_roles,
  $postgres_databases,
  $postgres_version = "9.3"
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

  create_resources("::postgresql::server::role", $postgres_roles)
  create_resources("::postgresql::server::database", $postgres_databases)
}