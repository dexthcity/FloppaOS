sudo docker build -t floppaos buildenv #if not installed
sudo docker run -it -v $PWD:/root/env floppaos /bin/bash #log in to env
