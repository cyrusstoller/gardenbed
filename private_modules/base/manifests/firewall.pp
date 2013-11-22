# This class sets up custom firewall rules modeled on:
# https://library.linode.com/securing-your-server#sph_creating-a-firewall
class base::firewall {
  resources { 'firewall':
    purge => true
  }

  Firewall {
    before  => Class['base::firewall::post'],
    require => Class['base::firewall::pre'],
  }

  class { ['base::firewall::pre', 'base::firewall::post']: }

  class { '::firewall': }

  firewall { '099 allow all outbound traffic':
    chain   => 'OUTPUT',
    action  => accept,
  }

  firewall { '100 allow http and https access':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }

  firewall { '101 allow ssh access':
    dport  => [22],
    proto  => tcp,
    state  => 'NEW',
    action => accept,
  }

  firewall { '110 iptables denied calls':
    limit      => '5/min',
    log_level  => 7,
    log_prefix => 'iptables denied: ',
    jump       => 'LOG',
  }
}