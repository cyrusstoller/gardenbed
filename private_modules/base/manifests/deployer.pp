# This class ensures that system users and ssh keys are in place
class base::deployer (
  # loaded from hiera
  $deployer_users = {},
  $ssh_keys       = {},
) {
  group { 'admin':
    ensure => present
  }

  group { 'deployers':
    ensure => present,
  }

  file { '/etc/sudoers.d/deployers':
    mode   => '0440',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/base/deployers'
  }

  $user_defaults = {
    managehome => true,
    password   => 'NP',
    membership => inclusive,
    ensure     => present,
    shell      => '/bin/bash',
    groups     => ['deployers'],
  }

  create_resources('user', $deployer_users, $user_defaults)

  $ssh_key_defaults = {
    ensure => present,
    type   => 'ssh-rsa',
  }

  create_resources('ssh_authorized_key', $ssh_keys, $ssh_key_defaults)
}