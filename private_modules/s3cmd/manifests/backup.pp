# Setup the cron jobs to sync directories to s3
define s3cmd::backup (
  $user,
  $directory = $title,
  $bucket
) {
  notify { "showing ${user}: ${directory} and ${bucket}": }
}