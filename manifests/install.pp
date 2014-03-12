# == Class: dashing::install
#
# This class makes sure that the required packages are installed.
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'dashing::install': }
#
class dashing::install {

  include apt

  apt::source {'ruby-ng':
    location    => 'http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu',
    repos       => 'main',
    release     => 'precise',
    key         => 'C3173AA6',
    key_server  => 'keyserver.ubuntu.com',
    include_src => false,
  }

  if !defined(Package['ruby1.9.3']) {
    package {'ruby1.9.3':
      ensure  => installed,
      require => Apt::Source['ruby-ng'],
    }
    package {'ruby-switch':
      ensure  => installed,
      require => Package['ruby1.9.3'],
    }
  }

  if !defined(Package['rubygems']) {
    package {'rubygems':
      ensure  => installed,
      require => Package['ruby1.9.3'],
    }
  }

  if !defined(Package['ruby-bundler']) {
    package {'ruby-bundler':
      ensure => installed,
      require => Package['ruby1.9.3'],
    }
  }

  if !defined(Package['nodejs']) {
    package {'nodejs':
      ensure => installed,
    }
  }

  file {$dashing::dashing_basepath:
    ensure => directory,
    owner  => $dashing::run_user,
    group  => $dashing::run_group,
    mode   => 0644,
  }

  package {$dashing::dashing_package_name:
    ensure   => $dashing::package_status,
    provider => 'gem',
  }

}
