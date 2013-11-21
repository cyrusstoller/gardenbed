class base_db::postgresql::roles (
  $postgres_roles,
) {
  create_resources("::postgresql::server::role", $postgres_roles) 
}