# == Class: dashing::params
#
# This defines default configuration values for dashing.  You don't want to use it directly.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::params': }
#
class dashing::params {

  case $::osfamily {
    debian: {
      $dashing_package_name   = 'dashing'
      $package_status         = 'installed'
      $dashing_conf           = '/etc/dashing.conf'
      $dashing_default        = '/etc/default/dashing'
      $dashing_binary         = '/usr/local/bin/dashing'
      $dashing_basepath       = '/usr/share/dashing'
      $run_user               = 'root'
      $run_group              = 'root'
      $service_name           = 'dashing'
      $enable                 = true
    }
    default: {
      case $::operatingsystem {
        default: {
          fail("Unsupported platform: ${::operatingsystem}")
        }
      }
    }
  }

}
