# This class sets up the default rails environment
class base::environment (
  $rails_env = 'production'
) {
  file { '/etc/profile.d/rails_environment.sh':
    ensure  => present,
    content => template('base/rails_environment.sh.erb'),
    mode    => '0666',
  }
}