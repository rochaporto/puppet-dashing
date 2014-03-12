# == Class: dashing::service
#
# This class enforces running of the dashing service.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::service': }
#
class dashing::service {

  service { $dashing::service_name:
    ensure  => running,
    enable  => true,
  }

  Class['dashing::config'] -> Service[$dashing::service_name]

}
