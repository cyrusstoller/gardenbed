class base_db(
  $postgres_details,
  $postgres_version = "9.3",
) {
  class { "base_db::postgresql":
    postgres_roles     => $postgres_details["roles"],
    postgres_databases => $postgres_details["databases"],
    postgres_version   => $postgres_version,
  }
}