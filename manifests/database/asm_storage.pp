#++--++
#
# ora_profile::asm_storage
#
# @summary This class sets up the storage for usage by ASM.
# Currently only NFS is supported as storage_type. ASMLIB and AFD will be added in a future release.
# Here you can customize some of the attributes of your storage.
# 
# When these customizations aren't enough, you can replace the class with your own class. See [ora_profile::database](./database.html) for an explanation on how to do this.
#
# @param [Enum['nfs', 'asmlib', 'afd']] storage_type
#    The type of ASM storage to use.
#    Currently only NFS is supported, ASMLIB and AFD will be added in a future release.
#    The default value is: `nfs`.
#
# @param [String[1]] grid_user
#    The name of the user that owns the Grid Infrastructure installation.
#    The default value is: `grid`.
#
# @param [String[1]] grid_admingroup
#    This is the name of the group that will have the NFS files for ASM.
#    The default value is: `asmadmin`.
#
# @param [Array[Stdlib::Absolutepath]] nfs_files
#    This is an array of NFS files that will be used as ASM disks.
#    The default value is:
#    ```yaml
#    ora_profile::database::asm_storage::nfs_files:
#    - /home/nfs_server_data/asm_sda_nfs_b1
#    - /home/nfs_server_data/asm_sda_nfs_b2
#    - /home/nfs_server_data/asm_sda_nfs_b3
#    - /home/nfs_server_data/asm_sda_nfs_b4
#    ```
#
# @param [Stdlib::Absolutepath] nfs_mountpoint
#    The mountpoint where the NFS volume will be mounted.
#    The default value is: `/nfs_client`.
#
# @param [Stdlib::Absolutepath] nfs_export
#    The name of the NFS volume that will be mounted to nfs_mountpoint.
#    The default value is: `/home/nfs_server_data`.
#
# @param [String[1]] nfs_server
#    The name of the NFS server.
#    The default value is: `localhost`.
#
#--++--
class ora_profile::database::asm_storage(
  Enum['nfs','asmlib','afd']
            $storage_type,
  String[1] $grid_user,
  String[1] $grid_admingroup,
  Array[Stdlib::Absolutepath]
            $nfs_files,
  Stdlib::Absolutepath
            $nfs_mountpoint,
  Stdlib::Absolutepath
            $nfs_export,
  String[1] $nfs_server,
) inherits ora_profile::database {

  echo {"Ensure ASM storage setup using ${storage_type}":
    withpath => false,
  }
  case $storage_type {
    'nfs': {
      class {'ora_profile::database::asm_storage::nfs':
        grid_user       => $grid_user,
        grid_admingroup => $grid_admingroup,
        nfs_files       => $nfs_files,
        nfs_mountpoint  => $nfs_mountpoint,
        nfs_export      => $nfs_export,
        nfs_server      => $nfs_server,
      }
    }
    'asmlib': {
      echo {"Storage type ${storage_type} not implemented yet":
        withpath => false,
      }
    }
    'afd': {
      echo {"Storage type ${storage_type} not implemented yet":
        withpath => false,
      }
    }
    default: {}
  }
}