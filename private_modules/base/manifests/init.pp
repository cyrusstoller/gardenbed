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
  
  # from http://forge.puppetlabs.com/puppetlabs/apt
  class { 'apt':
    # always_apt_update    => false,
    # disable_keys         => undef,
    # proxy_host           => false,
    # proxy_port           => '8080',
    # purge_sources_list   => false,
    # purge_sources_list_d => false,
    # purge_preferences_d  => false,
    update_timeout       => undef
  }
}