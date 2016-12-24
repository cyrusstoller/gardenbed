# This class defines the basic requirements for all servers
class base (
  $users        = {},
  $ssh_keys     = {},
  $ssh_port     = 22,
  $has_firewall = true,
  $rails_env    = 'production'
) {
  package { 'vim':
    ensure => installed
  }

  if ($has_firewall) {
    class { 'base::firewall':
      before => Class['fail2ban'],
    }
    class { 'fail2ban': }
  } else {
    notify { 'Not running firewall instructions': }
  }

  class { 'base::ssh':
    ssh_port => $ssh_port
  }

  class { 'base::deployer':
    deployer_users => $users,
    ssh_keys       => $ssh_keys,
  }

  class { 'base::environment':
    rails_env => $rails_env
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
  }

  class { 'monit':
    httpd         => true,
    httpd_address => 'localhost'
  }
}
