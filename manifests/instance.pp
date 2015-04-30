# == Class: dashing::instance
#
# Configuration for a specific dashing instance.
#
# === Parameters
#  [*targz*]            - url of the targz containing the dashing instance
#  [*dashing_port*]     - port to run the service under (default '3030')
#  [*dashing_dir*]      - local directory to store the dashing instance (default $dashing::dashing_basepath/$name)
#  [*strip_parent_dir*] - should the parent directory of the targz be stripped (default true)
#
# === Examples
#
#  dashing::instance {'ceph':
#    targz => 'https://github.com/rochaporto/dashing-ceph/tarball/master',
#    port  => '3030',
#  }
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
    unless  => "/bin/ls $dashing_dir/dashboards",
    notify  => Service[$dashing::service_name],
  }

  File["/etc/dashing.d/${name}.conf"] -> File[$dashing_dir] -> Exec["dashing-get-$name"]

}
