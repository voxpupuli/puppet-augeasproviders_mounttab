# mounttab: additional provider for the mounttab type for Puppet

This module provides an additional provider for the mounttab type
using the Augeas configuration library.

The advantage of using Augeas over the default Puppet `parsedfile`
implementations is that Augeas will go to great lengths to preserve file
formatting and comments, while also failing safely when needed.

This provider will hide *all* of the Augeas commands etc., you don't need to
know anything about Augeas to make use of it.

## Requirements

Ensure both Augeas and ruby-augeas 0.3.0+ bindings are installed and working as
normal.

## Installing

The module can be installed:

    puppet module install puppet/augeasproviders_mounttab

## Augeas version compatiblity

Augeas Versions           | 0.10.0  | 1.0.0   | 1.1.0   | 1.2.0   |
:-------------------------|:-------:|:-------:|:-------:|:-------:|
**PROVIDERS**             |
mounttab                  | **yes** | **yes** | **yes** | **yes** |

## Documentation and examples

Type documentation can be generated with `puppet doc -r type` or viewed on the
[Puppet Forge page](https://forge.puppetlabs.com/voxpupuli/augeasproviders_mounttab).

### mounttab provider

This is a provider for a type distributed in the [puppetlabs-mount_providers
module](https://forge.puppetlabs.com/puppetlabs/mount_providers).

The provider needs to be explicitly given as `augeas` to use `augeasproviders`.

If editing a vfstab entry, slightly different options need to be passed
compared to a fstab entry.

#### manage simple fstab entry

```puppet
mounttab { '/mnt':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  fstype   => 'ext4',
  options  => 'defaults',
  provider => augeas,
}
```

#### manage full fstab entry

```puppet
mounttab { '/mnt':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  fstype   => 'ext4',
  options  => ['nosuid', 'uid=12345'],
  dump     => '1',
  pass     => '2',
  provider => augeas,
}
```

#### manage fstab entry with default options

```puppet
mounttab { '/mnt':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  fstype   => 'ext4',
  provider => augeas,
}
```

#### delete fstab entry

```puppet
mounttab { '/':
  ensure   => absent,
  provider => augeas,
}
```

#### manage entry in another fstab location

```puppet
mounttab { '/home':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  target   => '/etc/anotherfstab',
  provider => augeas,
}
```

#### manage device in fstab entry only

```puppet
mounttab { '/home':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  provider => augeas,
}
```

Note: dump and pass are both changing unless explicitly specified, see issue
[#16122](http://projects.puppetlabs.com/issues/16122).

#### manage fstype in fstab entry only

```puppet
mounttab { '/home':
  ensure   => present,
  fstype   => 'btrfs',
  provider => augeas,
}
```

#### manage options in fstab entry only

```puppet
mounttab { '/home':
  ensure   => present,
  options  => 'nosuid',
  provider => augeas,
}
```

#### manage complex options in fstab entry only

```puppet
mounttab { '/home':
  ensure   => present,
  options  => [
    'nosuid',
    'uid=12345',
    'rootcontext='system_u:object_r:tmpfs_t:s0'',
  ],
  provider => augeas,
}
```

#### remove options from fstab entry

```puppet
mounttab { '/home':
  ensure   => present,
  options  => [],
  provider => augeas,
}
```

#### manage simple vfstab entry

```puppet
mounttab { '/mnt':
  ensure   => present,
  device   => '/dev/dsk/c1t1d1s1',
  fstype   => 'ufs',
  atboot   => 'yes',
  provider => augeas,
}
```

#### manage full vfstab entry

```puppet
mounttab { '/mnt':
  ensure      => present,
  device      => '/dev/dsk/c1t1d1s1',
  blockdevice => '/dev/foo/c1t1d1s1',
  fstype      => 'ufs',
  pass        => '2',
  atboot      => 'yes',
  options     => [ 'nosuid', 'nodev' ],
  provider    => augeas,
}
```

#### manage vfstab entry with default options

```puppet
mounttab { '/mnt':
  ensure   => present,
  device   => '/dev/myvg/mytest',
  fstype   => 'ext4',
  provider => augeas,
}
```

#### delete vfstab entry

```puppet
mounttab { '/':
  ensure   => absent,
  provider => augeas,
}
```

#### remove options from vfstab entry

```puppet
mounttab { '/home':
  ensure   => present,
  options  => [],
  provider => augeas,
}
```

## Issues

Please file any issues or suggestions [on GitHub](https://github.com/voxpupuli/puppet-augeasproviders_mounttab/issues).
