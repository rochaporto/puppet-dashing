# == Class: dashing::install
#
# This class makes sure that the required packages are installed.
#
# === Parameters: None
#
# === Examples
#
#  class { 'dashing::install': }
#
class dashing::install {

  file {$dashing::dashing_basepath:
    ensure => directory,
    owner  => $dashing::run_user,
    group  => $dashing::run_group,
    mode   => 0644,
  }

  package {$dashing::dashing_package_name:
    ensure   => $dashing::package_status,
    provider => 'gem',
    require  => Package['rubygems-integration'],
  }

  if !defined(Package['nodejs']) {
    package {'nodejs':
      ensure => installed,
    }
  }

  if !defined(Package['rubygems-integration']) {
    package {'rubygems-integration':
      ensure  => installed,
    }
  }

  if !defined(Package['ruby-bundler']) {
    package {'ruby-bundler':
      ensure => installed,
    }
  }

  # ruby version should be >= 1.9.x (1.8.x default in ubuntu precise)
  # it gets messy as puppet has a couple of required gems (augeas)
  if $::lsbdistcodename == 'precise' {

    if !defined(Package['ruby1.9.3']) {
      package {'ruby1.9.3':
        ensure => installed,
        notify => Exec['update-ruby-1.9.3'],
      }
    }

    if !defined(Package['libaugeas-ruby1.9.1']) {
      package {'libaugeas-ruby1.9.1':
        ensure  => installed,
        require => Package['ruby1.9.3'],
      }
    }

    exec {'update-ruby-1.9.3':
      command     => '/usr/sbin/update-alternatives --set ruby /usr/bin/ruby1.9.1; /usr/sbin/update-alternatives --set gem /usr/bin/gem1.9.1',
      refreshonly => true,
    }

    Package['libaugeas-ruby1.9.1'] -> Package['rubygems-integration'] ~> Exec['update-ruby-1.9.3'] -> Package[$dashing::dashing_package_name]

  }

}
