[![Puppet Forge Version](http://img.shields.io/puppetforge/v/herculesteam/augeasproviders_mounttab.svg)](https://forge.puppetlabs.com/herculesteam/augeasproviders_mounttab)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/herculesteam/augeasproviders_mounttab.svg)](https://forge.puppetlabs.com/herculesteam/augeasproviders_mounttab)
[![Puppet Forge Endorsement](https://img.shields.io/puppetforge/e/herculesteam/augeasproviders_mounttab.svg)](https://forge.puppetlabs.com/herculesteam/augeasproviders_mounttab)
[![Build Status](https://img.shields.io/travis/hercules-team/augeasproviders_mounttab/master.svg)](https://travis-ci.org/hercules-team/augeasproviders_mounttab)
[![Coverage Status](https://img.shields.io/coveralls/hercules-team/augeasproviders_mounttab.svg)](https://coveralls.io/r/hercules-team/augeasproviders_mounttab)
[![Gemnasium](https://img.shields.io/gemnasium/hercules-team/augeasproviders_mounttab.svg)](https://gemnasium.com/hercules-team/augeasproviders_mounttab)


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

See [Puppet/Augeas pre-requisites](http://docs.puppetlabs.com/guides/augeas.html#pre-requisites).

## Installing

On Puppet 2.7.14+, the module can be installed easily ([documentation](http://docs.puppetlabs.com/puppet/latest/reference/modules_installing.html)):

    puppet module install herculesteam/augeasproviders_mounttab

You may see an error similar to this on Puppet 2.x ([#13858](http://projects.puppetlabs.com/issues/13858)):

    Error 400 on SERVER: Puppet::Parser::AST::Resource failed with error ArgumentError: Invalid resource type `mounttab` at ...

Ensure the module is present in your puppetmaster's own environment (it doesn't
have to use it) and that the master has pluginsync enabled.  Run the agent on
the puppetmaster to cause the custom types to be synced to its local libdir
(`puppet master --configprint libdir`) and then restart the puppetmaster so it
loads them.

## Compatibility

### Puppet versions

Minimum of Puppet 2.7.

### Augeas versions

Augeas Versions           | 0.10.0  | 1.0.0   | 1.1.0   | 1.2.0   |
:-------------------------|:-------:|:-------:|:-------:|:-------:|
**PROVIDERS**             |
mounttab                  | **yes** | **yes** | **yes** | **yes** |

## Documentation and examples

Type documentation can be generated with `puppet doc -r type` or viewed on the
[Puppet Forge page](http://forge.puppetlabs.com/herculesteam/augeasproviders_mounttab).

### mounttab provider

This is a provider for a type distributed in the [puppetlabs-mount_providers
module](http://forge.puppetlabs.com/puppetlabs/mount_providers).

The provider needs to be explicitly given as `augeas` to use `augeasproviders`.

If editing a vfstab entry, slightly different options need to be passed
compared to a fstab entry.

#### manage simple fstab entry

    mounttab { "/mnt":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      fstype   => "ext4",
      options  => "defaults",
      provider => augeas,
    }

#### manage full fstab entry

    mounttab { "/mnt":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      fstype   => "ext4",
      options  => ["nosuid", "uid=12345"],
      dump     => "1",
      pass     => "2",
      provider => augeas,
    }

#### manage fstab entry with default options

    mounttab { "/mnt":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      fstype   => "ext4",
      provider => augeas,
    }

#### delete fstab entry

    mounttab { "/":
      ensure   => absent,
      provider => augeas,
    }

#### manage entry in another fstab location

    mounttab { "/home":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      target   => "/etc/anotherfstab",
      provider => augeas
    }

#### manage device in fstab entry only

    mounttab { "/home":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      provider => augeas
    }

Note: dump and pass are both changing unless explicitly specified, see issue
[#16122](http://projects.puppetlabs.com/issues/16122).

#### manage fstype in fstab entry only

    mounttab { "/home":
      ensure   => present,
      fstype   => "btrfs",
      provider => augeas,
    }

#### manage options in fstab entry only

    mounttab { "/home":
      ensure   => present,
      options  => "nosuid",
      provider => augeas,
    }

#### manage complex options in fstab entry only

    mounttab { "/home":
      ensure   => present,
      options  => [
        "nosuid",
        "uid=12345",
        'rootcontext="system_u:object_r:tmpfs_t:s0"',
      ],
      provider => augeas,
    }

#### remove options from fstab entry

    mounttab { "/home":
      ensure   => present,
      options  => [],
      provider => augeas,
    }

#### manage simple vfstab entry

    mounttab { "/mnt":
      ensure   => present,
      device   => "/dev/dsk/c1t1d1s1",
      fstype   => "ufs",
      atboot   => "yes",
      provider => augeas,
    }

#### manage full vfstab entry

    mounttab { "/mnt":
      ensure      => present,
      device      => "/dev/dsk/c1t1d1s1",
      blockdevice => "/dev/foo/c1t1d1s1",
      fstype      => "ufs",
      pass        => "2",
      atboot      => "yes",
      options     => [ "nosuid", "nodev" ],
      provider    => augeas,
    }

#### manage vfstab entry with default options

    mounttab { "/mnt":
      ensure   => present,
      device   => "/dev/myvg/mytest",
      fstype   => "ext4",
      provider => augeas,
    }

#### delete vfstab entry

    mounttab { "/":
      ensure   => absent,
      provider => augeas,
    }

#### remove options from vfstab entry

    mounttab { "/home":
      ensure   => present,
      options  => [],
      provider => augeas,
    }

## Issues

Please file any issues or suggestions [on GitHub](https://github.com/hercules-team/augeasproviders_mounttab/issues).
