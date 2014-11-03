docker-transmission
============

A nice and easy way to get a Transmission instance up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on Transmission and check out it's [website][1].


## Building

Running this will build you a docker image with the latest version of docker-transmission

    docker build -t captnbp/docker-transmission git://github.com/captnbp/docker-transmission.git


## Running Transmission

You can run this container with:

    sudo docker run -d -p 9091:9091 -p 51414:51414 -v /mydownloadfolder:/media/downloads -v /myconfigfolder:/config -e PASSWORD=yourpassword captnbp/docker-transmission

From now on when you start/stop docker-transmission you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `captnbp/docker-transmission:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>

### Notes on the run command

 + `-v` is the volume you are mounting `-v host_dir:docker_dir`
 + `-d  allows this to run cleanly as a daemon, remove for debugging
 + `-p  is the port it connects to, `-p=host_port:docker_port`


[0]: http://www.docker.io/gettingstarted/
[1]: https://www.transmissionbt.com/
