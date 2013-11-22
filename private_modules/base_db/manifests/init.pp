class base_db(
  $postgresql_roles,
  $postgresql_databases,
  $postgresql_version = "9.3",
) {
  class { "base_db::postgresql":
    postgres_roles     => $postgresql_roles,
    postgres_databases => $postgresql_databases,
    postgres_version   => $postgresql_version,
  }
}