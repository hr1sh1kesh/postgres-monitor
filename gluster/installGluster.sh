sudo apt-get install -y glusterfs-server

HOST=$(hostname)

if [[ $HOST = manager01 ]]; then
sudo gluster peer probe 192.168.17.102
sudo gluster peer probe 192.168.17.103
sudo gluster peer probe worker01
sudo gluster peer probe worker02
sudo mkdir -p /run/user/gluster/fs01 /mnt
fi
if [[ $HOST = worker01 ]]; then
sudo gluster peer probe 192.168.17.101
sudo gluster peer probe 192.168.17.103
sudo gluster peer probe manager01
sudo gluster peer probe worker02
sudo mkdir -p /run/user/gluster/fs01 /mnt
fi
if [[ $HOST = worker02 ]]; then
sudo gluster peer probe 192.168.17.101
sudo gluster peer probe 192.168.17.102
sudo gluster peer probe manager01
sudo gluster peer probe worker01
sudo mkdir -p /run/user/gluster/fs01 /mnt
fi


if [[ $HOST = manager01 ]]; then
sudo gluster volume create gfsvol1 replica 3 transport tcp 192.168.17.101:/run/user/gluster/fs01 192.168.17.102:/run/user/gluster/fs01 192.168.17.103:/run/user/gluster/fs01 
sudo gluster volume create gfsvol1 replica 3 transport tcp manager01:/run/user/gluster/fs01 worker01:/run/user/gluster/fs01 worker02:/run/user/gluster/fs01 
sudo gluster volume start gfsvol1
fi
for n in 1 2 3 
do
    
    sudo mount -t glusterfs ${HOST}:/gfsvol1 /mnt
done

#
# Start install of docker gluster plugin
#
# Install etherium
#
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ethereum/ethereum
sudo add-apt-repository ppa:ethereum/ethereum-dev
sudo apt-get update
sudo apt-get install -y ethereum

#
# Install go and mercurial
#
sudo apt-get install golang
sudo apt-get install gccgo
sudo apt-get install mercurial
sudo apt-get install -y git
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:$GOPATH/bin
go get github.com/calavera/docker-volume-glusterfs

nohup /home/vagrant/go/bin/docker-volume-glusterfs -servers manager01:worker01:worker02 &