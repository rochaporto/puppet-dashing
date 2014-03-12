puppet-dashing
=======

## Description

Provides puppet classes and definitions to deal with dashing.

==============

Overview
-------

The `dashing` module provides a simple interface to manage the installation of dashing and the install and configuration of dashing instances.

Module Description
------------------

dashing is a Sinatra based framework that lets you build beautiful dashboards.

Setup
-----

**What dashing affects:**

* dashing gem installation
* provides init/upstart service management scripts
* download and setup of dashing dashboards

### Beginning

As easy as

    include dashing

will give you a setup of dashing using all the default parameters.

Usage
-----

There are classes and definitions for the functionality described above.

### dashing

You must always include this class, it takes care of all the common install/setup.

The parameters for `dashing` are not required, but you can use them to customize.

    class {'dashing':
        dashing_package_name => 'dashing',
        package_status       => installed,
        dashing_conf         => '/etc/dashing.conf',
        dashing_default      => '/etc/default/dashing',
        dashing_binary       => '/usr/local/bin/dashing',
        dashing_basepath     => '/usr/share/dashing',
        run_user             => 'root',
        run_group            => 'root',
        service_name         => 'dashing',
        enable               => true,
    }

Defaults are enough for the usual locations after a `gem install dashing`, but you can overwrite them if your setup is different.

### dashing::instance

Handles the installation of a remote dashing dashboard.

Expects a targz location (gets extracted into `$dashing::dashing_basepath`), and handles the setup of upstart for that specific instance.

    dashing::instance {'ceph':
      targz            => 'https://github.com/rochaporto/dashing-ceph/tarball/master',
      dashing_port     => '3030',
      dashing_dir      => "$dashing::dashing_basepath/$name",
      strip_parent_dir => true,
    }

`strip_parent_dir` is a hint for tar to strip the parent directory (or not).

You should have `port` being different for each `dashing::instance` (but the actual instance might have multiple dashboards).

Limitations
-----------

Currently only upstart scripts are being provided to manage the service.

Development
-----------

All contributions more than welcome, just send pull requests.

License
-------

GPLv2 (check LICENSE).

Contributors
------------

Ricardo Rocha <ricardo@catalyst.net.nz>

Support
-------

Please log tickets and issues at the [github home](https://github.com/rochaporto/puppet-dashing/issues).
