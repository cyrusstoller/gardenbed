class base::deployer (
  $deployer_username       = "deployer",
  
  $shell                   = "/bin/bash",
  $deployer_groups         = ["admin", "deployers"],
  # non typeable password
  $deployer_password       = "NP",
  $deployer_public_ssh_key = "",
) {
  
  group { "deployers":
    ensure => present,
  }
  ->
  user { $deployer_username:
    comment => "Deployment User",
    ensure => "present",
    managehome => "true",
    shell => $shell,
    # figured out by setting the password with passwd and then checking /etc/shadow
    password => $password,
    groups => $deployer_groups,
  }
  
  unless( $deployer_public_ssh_key == "" ) {
    ssh_authorized_key { "deployer-ssh-key":
      key => $deployer_public_ssh_key,
      ensure => 'present',
      type => "ssh-rsa",
      user => $deployer_username,
    }
  }
  
}