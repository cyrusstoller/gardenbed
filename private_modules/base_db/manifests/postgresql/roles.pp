# This class defines the roles created in postgresql
class base_db::postgresql::roles (
  $postgres_roles = {},
) {
  create_resources('::postgresql::server::role', $postgres_roles)
}