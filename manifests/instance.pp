# == Class: dashing::instance
#
# Configuration for a specific dashing instance.
#
# === Parameters
#
# === Variables
#
# === Examples
#
define dashing::instance (
  $targz,
  $dashing_port = '3030',
  $dashing_dir = "$dashing::dashing_basepath/$name",
  $strip_parent_dir = true,
) {

  file {"/etc/dashing.d/${name}.conf":
    content => template('dashing/instance.conf.erb'),
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
  }

  file {$dashing_dir:
    ensure => directory,
    owner   => $dashing::run_user,
    group   => $dashing::run_group,
    mode    => 0644,
  }

  if $strip_parent_dir {
    $strip_parent_cmd = '--strip-components=1'
  }
  exec {"dashing-get-$name":
    command => "/usr/bin/wget $targz -O /tmp/$name.tar.gz; /bin/tar -zxvf /tmp/$name.tar.gz -C $dashing_dir $strip_parent_cmd; /bin/rm /tmp/$name.tar.gz",
    unless  => "/bin/ls $dashing::dashing_basepath/$name/dashboards",
    notify  => Service[$dashing::service_name],
  }

  File["/etc/dashing.d/${name}.conf"] -> File[$dashing_dir] -> Exec["dashing-get-$name"]

}
