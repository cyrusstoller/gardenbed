- Execute the contents of `scripts/upgrade_debian_based_puppet.sh` to install the latest version of puppet.
- rsync this manifests to your server with `deploy/rsync.sh deployer@<<SERVER IP>>:/tmp/puppet`
- copy or link the common.yaml file into the `hiera` directory
- Execute the contents of `deploy/puppet_apply_with_args.sh [MANIFEST]` this defaults to `manifests/production.pp`
but you may want to run `deploy/puppet_apply_with_args docker` to install the prerequisites for docker 
(note you don't need to add `.pp`)

---

For servers that already have a `~/common.yml` you can use `deploy/update.sh $HOST [$DESTINATION] [$MANIFEST]`
to rsync the manifests to the server and the run puppet.

For example:

```
$ deploy/update.sh deployer@revtilt.com
```

In this example the following is implied:

- `/tmp/puppet` is the `DESTINATION`
- `production` is the `MANIFEST` which is passed to `puppet_apply_with_args.sh`.
The `MANIFEST` file has to be in the `manifests` directory. This parameter is passed without the `.pp` suffix.