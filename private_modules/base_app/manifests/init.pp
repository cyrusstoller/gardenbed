# This class installs the rbenv, appropriate rubies, and node.js
class base_app (
  $rubies              = [],
  $deployer            = 'deployer',
  $deployers_group     = 'deployers',
  $default_ruby        = '',
  $additional_packages = [],
  $purge_packages      = [],
){
  include nodejs

  class { 'rbenv': 
    latest => true,  
  }
  rbenv::plugin { [ 'sstephenson/ruby-build' ]: 
    latest => true,
  }
  rbenv::build { $rubies:
    global => true,
    group  => $deployers_group,
  }
  ->
  file { "/usr/local/rbenv/version":
    ensure  => file,
    content => $default_ruby,
    owner   => $deployer,
    group   => $deployers_group,
  }

  file { '/var/www':
    ensure  => directory,
    group   => $deployers_group,
    owner   => 'root',
    mode    => '0775',
    require => Group['deployers']
  }

  package { $additional_packages:
    ensure => installed,
  }

  package { $purge_packages:
    ensure => purged,
  }
}