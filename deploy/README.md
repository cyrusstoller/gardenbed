- Execute the contents of `scripts/upgrade_debian_based_puppet.sh` to install the latest version of puppet.
- rsync this manifests to your server with `deploy/rsync.sh deployer@<<SERVER IP>>:/tmp/puppet`
- copy or link the common.yaml file into the `hiera` directory
- Execute the contents of `deploy/puppet_apply_with_args.sh` 

---

For servers that already have a `~/common.yml` you can use `deploy/update.sh $HOST [$DESTINATION]`
to rsync the manifests to the server and the run puppet.

For example:

```
$ deploy/update.sh deployer@revtilt.com
```

In this example the `/tmp/puppet` destination is implied.