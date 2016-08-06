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