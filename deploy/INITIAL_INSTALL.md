## Production

```bash
$ deploy/rsync.sh root@XXX.XXX.XXX.XXX:/tmp/puppet
$ scripts/upgrade_debian_based_puppet.sh
```

- Set up a `common.yaml` in `/tmp/puppet/hiera/common.yaml`
- Remove the `templatedir` to eliminate the deprecation warnings from puppet
in `/etc/puppet/puppet.conf`

```bash
$ deploy/puppet_apply_with_args.sh [manifest]
```

- `production` is the default manifest and can be omitted. If you prefer `docker`
then it needs to be supplied.

Open a new terminal window and ssh in

```bash
$ ssh deployer@XXX.XXX.XXX.XXX
```

And then copy the `common.yaml` you made.

```bash
cp /tmp/puppet/hiera/common.yaml ~
```