# This class defines the last firewall rules
class base::firewall::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    before  => undef,
  }

  firewall { '999 drop forward':
    proto   => 'all',
    action  => 'drop',
    chain   => 'FORWARD',
    before  => undef,
  }
}
