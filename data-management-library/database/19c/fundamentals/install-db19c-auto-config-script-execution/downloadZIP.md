## **STEP 1**: Stage the Oracle Database 19c installation ZIP file in object storage in Oracle Cloud Infrastructure

1. In a browser on your local machine, access `https://www.oracle.com/database/technologies/oracle-database-software-downloads.html#19c`.

2. Scroll down to **Linux x86-64** and click the **ZIP** link (2.8GB).

3. In the dialog box, select the **I reviewed and accept the Oracle License Agreement** check box.

4. Click the **Download LINUX.X64_193000_db_home.zip** button, and download the file to your browser's download directory.

5. From the Oracle Cloud Infrastructure navigation menu, select **Object Storage**, and then **Object Storage**. The **Objects Storage** page is displayed.

6. On the right, click **Create Bucket**. The **Create Bucket** dialog box is displayed.

7. Leave the default values as is, and click **Create**.

8. Click the name of your bucket, and then scroll down to the **Object** section.

9. Click **Upload**. The **Upload Objects** dialog box is displayed.

10. In the **Choose Files from your Computer** area, click **select files**. The **File Upload** dialog box is displayed.

11. Browse to and select your Oracle Database 19c install ZIP file, and then click **Open**. The install ZIP file for Oracle Database 19.3 is 2.86 GB.

12. Click **Upload**.

13. Wait for the upload to finish. It takes about 15 minutes.

14. Click the three dots in the object storage table for your ZIP file, and select **Create Pre-Authentication Request**. The **Create Pre-Authentication Request** dialog box is displayed.

15. In the **Expiration** field, click the calendar icon, and set a date in the future for the pre-authentication request to end.

16. Leave the other settings as is to permit reads on the object, and click **Create Pre-Authentication Request**. The **Pre-Authenticated Request Details** dialog box is displayed.

17. Copy the pre-authenticated request URL to the clipboard. You can use the copy button.

18. Paste the url into a text editor, such as Notepad, where you can access it later.

19. Click **Close**.



4. Create a `dba` group, `oinstall` group, and an `oracle` user account. Add `oracle` to both the `oinstall` and `dba` groups.


** groupadd db, oinstall, and oracle user already created.
    ```nohighlighting
    # <copy>groupadd dba</copy>
    # <copy>groupadd oinstall</copy>
    # <copy>useradd -m -g oinstall -g dba oracle</copy>
    ```

    REVIWER: This is here temporarily for Jody's testing purposes:
    wget https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/m3rTsRbg5ofiqEWJtqo-pfR18VVngF_8oq-KtroohAvQ_rZ1Gsw03QarPuR9O2v4/n/frmwj0cqbupb/b/bucket-20210401-1123/o/LINUX.X64_193000_db_home.zip -P /stage





    1. Switch to the `root` user.

      ```nohighlighting
            $ <copy>sudo su -</copy>
            ```

      2. Find out how many swap partitions exist on your compute instance.

          ```nohighlighting
          # <copy>swapon -s</copy>

          Filename                                Type            Size    Used    Priority
          /dev/sda2                               partition       8388604 0       -2
          ```
          The output indicates that there is one swap partition, and it is 8GB.


      3. View details about the swap partition.

          ```nohighlighting
          # <copy>free -m</copy>

                        total        used        free      shared  buff/cache   available
          Mem:          31824        1151       19582           8       11091       30209
          Swap:          8191           0        8191
          ```

          The output indicates that there is 8GB of free swap space.

      4. Identify a file system that has space available that you can turn into free swap space.  

          ```nohighlighting
          # <copy>df -h</copy>

          Filesystem      Size  Used Avail Use% Mounted on
          devtmpfs         16G     0   16G   0% /dev
          tmpfs            16G     0   16G   0% /dev/shm
          tmpfs            16G  8.8M   16G   1% /run
          tmpfs            16G     0   16G   0% /sys/fs/cgroup
          /dev/sda3        39G   13G   26G  34% /
          /dev/sda1       200M  8.6M  192M   5% /boot/efi
          tmpfs           3.2G     0  3.2G   0% /run/user/0
          tmpfs           3.2G     0  3.2G   0% /run/user/994
          tmpfs           3.2G     0  3.2G   0% /run/user/1000
          ```

          The output indicates that `/dev/sda3` has 26G available.

      5. Find the current swap space.

          ```nohighlighting
          # <copy>cat /etc/fstab</copy>

          #
          # /etc/fstab
          # Created by anaconda on Wed Mar 17 22:21:38 2021
          #
          # Accessible filesystems, by reference, are maintained under '/dev/disk'
          # See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
          #
          UUID=8381a3a6-892e-40a0-bbaf-3423632fdf6c /                       xfs     defaults,_netdev,_netdev 0 0
          UUID=0F1D-8861          /boot/efi               vfat    defaults,uid=0,gid=0,umask=0077,shortname=winnt,_netdev,_netdev,x-initrd.mount 0 0
          UUID=154d2352-4fc7-471b-a4bb-efd52ae00a8b swap                    swap    defaults,_netdev,x-initrd.mount 0 0
          ######################################
          ## ORACLE CLOUD INFRASTRUCTURE CUSTOMERS
          ##
          ## If you are adding an iSCSI remote block volume to this file you MUST
          ## include the '_netdev' mount option or your instance will become
          ## unavailable after the next reboot.
          ## SCSI device names are not stable across reboots; please use the device UUID instead of /dev path.
          ##
          ## Example:
          ## UUID="94c5aade-8bb1-4d55-ad0c-388bb8aa716a"   /data1    xfs       defaults,noatime,_netdev      0      2
          ##
          ```
          The output indicates that the current swap space is:

          `UUID=154d2352-4fc7-471b-a4bb-efd52ae00a8b swap                   swap   defaults,_netdev,x-initrd.mount 0 0`
