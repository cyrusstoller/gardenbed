# This class configures the ssh service
class base::ssh (
  $ssh_port = 22
) {
  class { 'ssh::server':
    port                    => $ssh_port,
    permit_root_login       => 'no',
    password_authentication => 'no', # should be no for security
  }
}