# == Class: dashing
#
# Configures the dashing service and instances.
#
# === Parameters
#
# === Examples
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
