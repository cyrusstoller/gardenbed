# This class configures the ssh service
class base::ssh (
  $ssh_port = 22
) {
  class { '::ssh':
    sshd_config_port             => $ssh_port,
    permit_root_login            => 'no',
    sshd_password_authentication => 'no', # should be no for security
  }
}
