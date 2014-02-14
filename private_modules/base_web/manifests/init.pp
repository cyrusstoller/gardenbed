# This class installs nginx
class base_web {
  class { 'nginx':
    # http_cfg_append => {
    #   'include' => '/etc/nginx/sites-enabled/*.conf'
    # }
  }

  # file { '/etc/nginx/sites-available':
  #   ensure => 'directory',
  #   owner  => 'root',
  #   group  => 'deployers',
  #   mode   => '0775'
  # }

  # file { '/etc/nginx/sites-enabled':
  #   ensure => 'directory',
  #   owner  => 'root',
  #   group  => 'deployers',
  #   mode   => '0775'
  # }
}