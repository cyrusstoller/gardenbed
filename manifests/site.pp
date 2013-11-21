class { 'base':
  deployer_public_ssh_key => hiera("deployer_public_ssh_key"),
}