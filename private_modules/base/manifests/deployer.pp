class base::deployer (
  # loaded from hiera
  $deployer_users,
  $ssh_keys,
) {  
  group { "deployers":
    ensure => present,
  }
  create_resources("user", $deployer_users)
  create_resources("ssh_authorized_key", $ssh_keys)
}