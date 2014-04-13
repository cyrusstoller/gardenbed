# Setup the cron jobs to sync directories to s3
define s3cmd::backup (
  $user,
  $directory = $title,
  $bucket
) {
  cron { "backing up ${directory}":
    ensure  => present,
    command => "s3cmd sync -r --no-encrypt --delete-removed ${directory} s3://${bucket}/${fqdn}/",
    user    => $user,
    hour    => '4',
    minute  => '30',
  }
}