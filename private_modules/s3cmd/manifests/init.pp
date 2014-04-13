# Class to install s3cmd credentials
# Ref: http://abhishek-tiwari.com/hacking/jekyll-amazon-s3-vagrant-and-puppet
class s3cmd (
  $user           = 'deployer',
  $group          = 'deployer',
  $access_key     = undef,
  $secret_key     = undef,
  $gpg_passphrase = undef,
) {
  $base_dir = "/home/${s3cmd::user}"

  if $access_key and $secret_key {
    if $gpg_passphrase {
      $encrypt = 'True'
    } else {
      $encrypt = 'False'
    }

    package { 's3cmd':
      ensure => installed,
    }

    file { "${base_dir}/.s3cfg":
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '0600',
      # content or source or target
      content => template('s3cmd/s3cfg.erb'),
    }
  } else {
    notify { 'failed to load necessary s3 credentials for s3cmd': }
  }
}