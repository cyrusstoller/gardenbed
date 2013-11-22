class { 'base':
  user_configs => hiera("user_configs"),
  # # Uncomment the following line if you are provisioning a Vagrant box for development
  # has_firewall => false
}

class { 'base_db':
  postgres_details => hiera("postgresql"),
  require => Class['base']
}

class { 'base_web':
  require => Class['base']
}

class { 'base_app':
  rubies => hiera("rubies"),
  require => Class['base']
}