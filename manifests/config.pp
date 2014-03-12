# == Class: dashing::config
#
# Configuration for the dashing service.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::config': }
#
class dashing::config {

  file {'/etc/dashing.d':
    ensure => directory,
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0755,
  }

  file {$dashing::dashing_default:
    content => template('dashing/default.erb'),
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
    notify  => Service[$dashing::service_name],
  }

  file {'/etc/init/dashing.conf':
    content => template('dashing/dashing.upstart.erb'),
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
  }

  file {'/etc/init/dashing-instance.conf':
    content => template('dashing/dashing-instance.upstart.erb'),
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
  }

  Class['dashing::install'] -> Class['dashing::config']

}
