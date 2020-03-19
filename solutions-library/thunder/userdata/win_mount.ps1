#ps1_sysnative
Start-Transcript
Sleep 250

# takes a disk number and creates a partition on it
function CreatePartitionOnDisk {
    Param ($number,$mount_point)
    
    Initialize-Disk -Number $number -PartitionStyle GPT
    New-Partition -DiskNumber $number -UseMaximumSize -DriveLetter $mount_point
    Format-Volume -DriveLetter $mount_point -FileSystem NTFS -confirm:0
    
    return
}

# keep track which disk has been used - 0 means unformatted
$formatted = @(0) * ((Get-Disk | Select number).length)

# parse input, example mapping -> "D:50GB E:60GB F:80GB"
$device_disk_mappings='${device_disk_mappings}'
$device_disk_mappings=$device_disk_mappings.split(' ')
foreach($device in $device_disk_mappings) {
    $mount_point=$device.split(':')[0]
    $disk_size=$device.split(':')[1]
    # 2 possibilities for disk sizes
    $number=(Get-Disk | Where-Object { $_.Size -eq $disk_size } | select number).number
    # 1) same size in only 1 disk
    if($number.length -eq 1) {
        CreatePartitionOnDisk $number $mount_point
    # 2) same size for multiple disks
    } elseif($number.length -gt 1) {
        foreach($potential_disk in $number) {
            # disk not formatted yet
            if($formatted[$potential_disk] -eq 0) {
                CreatePartitionOnDisk $potential_disk $mount_point
                $formatted[$potential_disk] = 1
                break # mount point solved
            }
            # disk previously formatted -> look for the others with same size
            else {continue}
        }
    } else {
        echo "Error !"
    }
}