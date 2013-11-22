# This class defines the databases created in postgresql
class base_db::postgresql::databases (
  $postgres_databases = {},
){
  create_resources('::postgresql::server::database', $postgres_databases)
}