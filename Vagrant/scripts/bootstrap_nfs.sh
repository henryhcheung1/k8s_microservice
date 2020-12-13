#filename=bootstrap_nfs.sh

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.99 nfs-server.example.com nfs-server
EOF

echo "[TASK 2] Download and install NFS server"
yes| sudo pacman -S nfs-utils

echo "[TASK 3] Create a data directory"
mkdir -p /srv/nfs/data
# mkdir -p /srv/nfs/kubedata/db
# mkdir -p /srv/nfs/kubedata/storage
# mkdir -p /srv/nfs/kubedata/logs

echo "[TASK 4] Update the shared folder access"
chmod -R 777 /srv/nfs/data

echo "[TASK 5] Make the data directory available on the network"
cat >>/etc/exports<<EOF
/srv/nfs/data    *(rw,sync,no_subtree_check,no_root_squash)
EOF

echo "[TASK 6] Export the updates"
sudo exportfs -rav

echo "[TASK 7] Enable NFS Server"
sudo systemctl enable nfs-server

echo "[TASK 8] Start NFS Server"
sudo systemctl start nfs-server
