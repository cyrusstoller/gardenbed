class { 'base':
  deployer_public_ssh_key => hiera("deployer_public_ssh_key"),
}

class { 'base_db':
  postgres_details => hiera("postgresql"),
}