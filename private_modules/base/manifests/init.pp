class base (
  $users,
  $ssh_keys,
  $ssh_port = 22,
  $has_firewall = true
) {
  package { "vim":
    ensure => installed
  }
  
  if ($has_firewall) {
    include base::firewall
  } else {
    notify { "Not running firewall instructions": }
  }
  
  class { 'base::ssh':
    ssh_port => $ssh_port
  }
  
  class { 'base::deployer':
    deployer_users => $users,
    ssh_keys       => $ssh_keys,
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