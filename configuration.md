# Configuration

- Copy `hiera/common.yaml.example` to `hiera/common.yaml`
- You should see five top level keys in this `yaml` file. We'll go through what each sets up.

- `additional_packages`
  - List any other packages you want installed (e.g. imagemagick)

- `postgresql_roles`
  - Here you should describe all of the roles you want defined with postgresql.
  - By default, there's a role called `deployer` with password set to `foobar`.
  - You can add as many other roles as you like here.
  - These roles are what you will use as the `username` in your `database.yml` file if you are building a Rails project.
  - For more details on the arguments you can pass to the roles check out the module's
   [documentation](http://forge.puppetlabs.com/puppetlabs/postgresql) for `postgresql::server::role`.
  - If you prefer a different password you can change the value of the `password_hash`.
  - To calculate the new hash use the following:

```bash
$> echo -n "md5"; echo "<<PASSWORD>><<USERNAME>>" | md5
```

- `postgresql_databases`
  - Here you list all of the databases that you want to be created
  - By default, a database called `revtilt_production` is created and it is owned by the `deployer` role
  - The `owner` should be defined above in the `postgresql_roles` section
  - You can add as many databases as you like here by adding new keys
  - If you uncomment `my_database` you would have another database called `my_database`
	- Also be sure change the `postgres_password`. This used to allow to facilitate automatic database backups.

- `purge_packages`
  - List any packages that you want purged from the sytem

- `redis_version`
  - Specify the [redis](http://redis.io/) version number. This defaults to 2.8.13.
  
- `rubies`
  - Here you list all of the rubies that you want to be installed using [rbenv](https://github.com/sstephenson/rbenv)
  - Be sure to specify the patch number
  - By default ruby 2.0.0-p481 will be installed
  - To also install ruby 1.9.3-p545 just uncomment it in your `hiera/common.yaml` file

- `default_ruby`
  - Set to 2.0.0-p481

- `default_rails_env`
  - Set to `development` or `production` by default

- `s3` (optional, this can be omitted)
  - Here you list your AWS security credentials (ie `access_key` and `secret_key`)
  - You can specify a `gpg_passphrase` if you want to encrypt data before sending it to S3
  - You specify the `bucket name` for automatic database backups and the `user` that will run the `cron` job

- `users`
  - Here you list all of the additional users that you would like created on your system.
  - By default, Vagrant will add another user named `vagrant` with password `vagrant`.
  - In the `common.yaml` there is also a user called `deployer`.
  - To find more options that can be passed, read [this](http://docs.puppetlabs.com/references/latest/type.html#user)
   
- `ssh_keys`
  - Here you list all of the ssh public keys that you want installed on your system
  - Each key here needs to be unique, but `deployer_key` has no other significance.
  - The user should have been specified in the `users` section
  - You can find your public key by copying and pasting you the output of `$> cat ~/.ssh/id_rsa.pub` or you can 
  use the public ssh key you have on github by going to the following url: `https://github.com/<<GITHUB_USERNAME>>.keys`.
  - Be sure to chop off the leading `ssh-rsa ` before adding your key(s) to `hiera/common.yaml`
  - To find more options that can be passed, read [this](http://docs.puppetlabs.com/references/latest/type.html#sshauthorizedkey)