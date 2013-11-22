# This class defines the first firewall rules
class base::firewall::pre {
  Firewall {
    require => undef,
  }

  # Default firewall rules

  firewall { '000 accept all icmp':
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '001 drop all traffic to 127/8':
    destination => '127.0.0.0/8',
    action      => 'reject',
  }->
  firewall { '002 accept related established rules':
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }
}
