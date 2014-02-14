# Basic Puppet Template for a basic Ruby + PostgreSQL + Nginx stack

These puppet manifests are intended to be a starting point for using [Ruby](https://www.ruby-lang.org/),
with [PostgreSQL](http://www.postgresql.org/) and [Nginx](http://nginx.com/).

Some of my projects no longer seem to fit neatly into the Heroku's offerings, so I decided to
migrate them to VPS services like [Linode](https://www.linode.com/), [Digital Ocean](https://digitalocean.com/)
or others that offer SSH access. This saves on cost and increases control of deployment.

Clearly, as applications grow this will certainly need to be customized, but for new projects this should
hopefully prevent you from having to reinvent the wheel. My goal with this is to make it easy to host
one or more rails applications on the same server while minimizing lock-in to a given provider,
while refactoring sensitive information so that it can easily stay outside of source control.

This project should also help with setting up Vagrant for development, which will alleviate the problems that
arise from collaborators using different development environments.

If you've ever heard someone say, "your code doesn't work on my computer," then you know what I'm talking about.

## Quick start guide for development

- Install [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://www.vagrantup.com/) using the [installer](http://www.vagrantup.com/downloads.html). Previously you
could install it as a rubygem, but that behavior has since been deprecated. Go to the website. 
This was built with [version 1.4.3](https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.3.dmg).
- Clone this repository with `git clone git@github.com:cyrusstoller/gardenbed.git`
- `cd` into the cloned repository
- Run the following command

```bash
$> scripts/bootstrap.sh development
```

- *Warning* During this initial provisioning your CPU will be very busy. Close any unnecessary applications.
Web browsers especially. This process will take a while.
Don't worry about some error messages on during this initial run. Just let it keep going until you have your command prompt back.
Go get some coffee and come back in a half hour.
- Everything in this the `gardenbed` directory will be accessible from your virtual machine at `/vagrant`.
In other words your files will be both on your virtual machine and on your host machine, meaning you can continue to use
your favorite text editor and maintain a similar workflow without having to worry about system dependencies.
- SSH into your machine with:

```bash
$> vagrant ssh
```

- Then go to your project directory in `/vagrant` and `bundle install` and `bundle exec rails s` or `bundle exec foreman start` 
and you should be good to go.
- Your website should be viewable at `http://localhost:3000` or `http://localhost:5000` depending on how your application is configured.

### What's been configured
- [rbenv](https://github.com/sstephenson/rbenv) with ruby v2.0.0-p353 installed
- [postgresql](http://www.postgresql.org/) version 9.3.1+ with role/username `vagrant` with password `foobar` and 
encoding `UTF8` and locale `en_US.UTF-8`.
- [nodejs](http://nodejs.org/) needed for the asset pipeline

## Getting started for staging / mock-production

- Install [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
- Install [Vagrant](http://www.vagrantup.com/) using the [installer](http://downloads.vagrantup.com/). Previously you
could install it as a rubygem, but that behavior has since been deprecated. Go to the website. 
This was built with [version 1.3.5](http://downloads.vagrantup.com/tags/v1.3.5).
- Clone this repository with `git clone git@github.com:cyrusstoller/gardenbed.git`
- `cd` into the cloned repository
- `cp hiera/common.yaml.example hiera/common.yaml`
- Go to `https://github.com/<<GITHUB_USERNAME>>.keys` and copy your SSH key into the last line of your `hiera/common.yaml`
- Run the following command

```bash
$> scripts/bootstrap.sh staging
```

- This configures a `deployer` user that has you can SSH into using:

```bash
$> ssh deployer@192.168.33.11
```

### What's been configured
- a firewall as recommended by https://library.linode.com/securing-your-server#sph_creating-a-firewall
- an ssh key for the `deployer` user, which is ideal for practicing deployment with a tool like [Capistrano](http://www.capistranorb.com/)
- after deploying to this machine you will be able to view `http://192.168.33.11` on port 80
- [rbenv](https://github.com/sstephenson/rbenv) with ruby v2.0.0-p353 installed
- [postgresql](http://www.postgresql.org/) version 9.3.1+ with role/username `deployer` with password `foobar` and 
encoding `UTF8` and locale `en_US.UTF-8`.
- [nodejs](http://nodejs.org/) needed for the asset pipeline
- [nginx](http://nginx.com/) for serving static assets

The `hiera/common.yaml` makes it really easy to provision more system users, create more roles and databases for postgresql, 
and install more rubies. See below for more details.

## Vagrant

If you've never used Vagrant before, go check out: http://docs.vagrantup.com/v2/

Here's an old [Railscasts episode](http://railscasts.com/episodes/292-virtual-machines-with-vagrant) that explains many
of the steps that this project is helping you bypass.

### Other operating systems

If you are interested in using a non-debian-based box, I suggest checking out: http://www.vagrantbox.es/

## Configuration

- Copy `hiera/common.yaml.example` to `hiera/common.yaml`
- You should see five top level keys in this `yaml` file. We'll go through what each sets up.

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
  
- `rubies`
  - Here you list all of the rubies that you want to be installed using [rbenv](https://github.com/sstephenson/rbenv)
  - Be sure to specify the patch number
  - By default ruby 2.0.0-p247 will be installed
  - To also install ruby 1.9.3-p448 just uncomment it in your `hiera/common.yaml` file
  
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

## Making Changes

If you want to make modifications to the modules, be sure to do so in the `private_modules` directory.
The `modules` directory that is used during `puppet apply` is overwritten each time you run
`librarian-puppet update`. Speaking of which, to use a change you make in the `private_modules` directory you
need to run `librarian-puppet update` before you run `vagrant provision`.

## Contributing

### Bugs / Issues

If you find a bug or something that could improve the user experience, please file an issue on this github project.

Even if you plan on filing a patch for the issue yourself it'd be great if you could still file an issue so that we
don't have people duplicating work unnecessarily.

### Submitting Pull Requests

1. Fork this project
2. Make a feature branch `git checkout -b feature`
3. Make your changes and commit them to your feature branch
4. Submit a pull request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/cyrusstoller/gardenbed/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

