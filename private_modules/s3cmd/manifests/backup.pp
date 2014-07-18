# Setup the cron jobs to sync directories to s3
define s3cmd::backup (
  $user,
  $bucket,
  $directory = $title
) {
  $destination = "s3://${bucket}/${::fqdn}/"
  $options = '-r --no-encrypt --delete-removed'

  cron { "backing up ${directory}":
    ensure  => present,
    command => "s3cmd sync ${options} ${directory} ${destination}",
    user    => $user,
    hour    => '4',
    minute  => '30',
  }
}