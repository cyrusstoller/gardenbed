class { 'docker':
  version => "0.11.1",
  before  => Class['base::deployer']
}

package { 'vim':
  ensure => installed
}

class { 'base::firewall':
  before => Class['fail2ban'],
}

class { 'fail2ban': }

class { 'base::ssh':
  ssh_port => 22,
}

class { 'base::deployer':
  deployer_users => hiera('users', {}),
  ssh_keys       => hiera('ssh_keys', {}),
}
