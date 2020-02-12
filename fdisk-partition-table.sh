# Bash script for automatic creation of partition table when 
# installing new system.
# Sed strips off all the comments so that we can document what 
# we're doing in-line with the actual commands.
# Attention: empty lines (commented as 'default') are required
# and will send a empty line terminated with a newline to take
# the fdisk default.
# Run directly from github: 
# wget -O - https://raw.githubusercontent.com/md1guy/fdisk-partition-table/master/fdisk-partition-table.sh | bash
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  o # clear the in memory partition table
  n # new partition
  p # primary partition
    # default: partition 1
    # default: start at the beginning of disk
  +500M # allocate 500 MB for this partition
  n # new partition
  p primary partition
    # default: partition 2
    # default: start at the end of previous partition
  +8G # allocate 8 GB for this partition
  t # change partition type
  2 # choose partition 2
  82 # select 'Linux swap' partition type
  n # new partition
  p # primary partition
   # default: partition 3
   # default: start at the end of previous partition
   # default: allocate rest of unused disk space for this partition
  a # choose bootable partition
  1 # bootable partition is partition 1 (/dev/sda1)
  p # print the in-memory partition table
  w # write the partition table
  q # quit fdisk
EOF