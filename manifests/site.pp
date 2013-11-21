class { 'base':
  user_configs => hiera("user_configs"),
}

class { 'base_db':
  postgres_details => hiera("postgresql"),
}