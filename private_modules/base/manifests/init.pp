class base (
  $ssh_port = 22,
  $deployer_username = 'deployer',
  $deployer_public_ssh_key = ""
) {
  include base::firewall
  
  package { "vim":
    ensure => installed
  }
  
  class { 'base::ssh':
    ssh_port => $ssh_port
  }
  
  class { 'base::deployer':
    deployer_username       => $deployer_username,
    deployer_public_ssh_key => $deployer_public_ssh_key,
  }
}