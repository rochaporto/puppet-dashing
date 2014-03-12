# == Class: dashing
#
# Configures the dashing service and instances.
#
# === Parameters
#  [*dashing_package_name*] - the name of the dashing package (as in gem install <name>)
#  [*package_status*]       - install status of dashing package (installed, latest, ...)
#  [*dashing_conf*]         - dashing configuration file (default /etc/dashing.conf)
#  [*dashing_default*]      - init/upstart defaults (default /etc/default/dashing)
#  [*dashing_binary*]       - name of the dashing binary (for service)
#  [*dashing_basepath*]     - location of the dashing instances (default /usr/share/dashing)
#  [*run_user*]             - user to run the service (default 'root')
#  [*run_group*]            - group to run the service (default 'root')
#  [*service_name*]         - name of the dashing service (default 'dashing')
#  [*enable*]               - should the service be started (default 'true')
#
# === Examples
#
#  class {'dashing':
#    run_user  => 'apache2',
#    run_group => 'apache2',
#  }
#
# === Authors
#
# Ricardo Rocha <ricardo@catalyst.net.nz>
#
# === Copyright
#
# Copyright 2014 Catalyst IT, Limited
#
class dashing (
  $dashing_package_name = $dashing::params::dashing_package_name,
  $package_status       = $dashing::params::package_status,
  $dashing_conf         = $dashing::params::dashing_conf,
  $dashing_default      = $dashing::params::dashing_default,
  $dashing_binary       = $dashing::params::dashing_binary,
  $dashing_basepath     = $dashing::params::dashing_basepath,
  $run_user             = $dashing::params::run_user,
  $run_group            = $dashing::params::run_group,
  $service_name         = $dashing::params::service_name,
  $enable               = $dashing::params::enable,
) inherits dashing::params {

  class { 'dashing::install': }
  class { 'dashing::config': }
  class { 'dashing::service': }

}
