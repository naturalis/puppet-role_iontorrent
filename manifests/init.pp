# == Class: role_iontorrent
#
# Manifest for installing additional support software on iontorrent server. 
# 
# === Authors
#
# Author Name <hugo.vanduijn>
#
#
class role_iontorrent (
  $destination            = 'ionbackup@x.x.x.x:/data/ionbackup',
  $scriptdir              = '/opt/ionbackup',
  $privatekeyname         = 'ionbackup.key',
  $throttle               = '6400',
  $removefromarchive      = '730',
  $cronhour               = '19',
  $cronminute             = '0',
  $aws_access_key_id      = 'keyid',
  $aws_secret_access_key  = 'accesskey',
  $aws_archive_bucket     = 'iontorrent-archive'
 )
{
  file { $scriptdir:
    ensure        => 'directory',
  }

  file { '/root/.aws':
    ensure        => 'directory',
    mode          => '0700'
  }

  file {"/root/.aws/config":
    ensure        => 'file',
    mode          => '0600',
    content       => template('role_iontorrent/awsconfig.erb'),
    require       => File['/root/.aws']
  }

  ensure_packages('python-pip')

  ensure_packages(['awscli'], {
    ensure   => present,
    provider => 'pip',
    require  => [ Package['python-pip'], ],
  })

  file {"${scriptdir}/ionbackup.sh":
    ensure        => 'file',
    mode          => '0755',
    content       => template('role_iontorrent/ionbackup.sh.erb'),
    require       => File[$scriptdir]
  }

  file {"${scriptdir}/${privatekeyname}":
    ensure        => 'file',
    mode          => '0600',
    source        => 'puppet:///modules/role_iontorrent/ionbackup.key',
    require       => File[$scriptdir]
  }

  cron { 'ionbackup':
    command       => "${scriptdir}/ionbackup.sh",
    user          => 'root',
    minute        => $cronminute,
    hour          => $cronhour,
    require       => File["${scriptdir}/ionbackup.sh"]
  }

  file { '/etc/logrotate.d/ionbackup':
    ensure        => present,
    mode          => '0644',
    source        => 'puppet:///modules/role_iontorrent/logrotate_ionbackup',
  }
}
