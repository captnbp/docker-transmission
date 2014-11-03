FROM    ubuntu:14.04
MAINTAINER      Benoît Pourre "benoit.pourre@gmail.com"

RUN     locale-gen en_US en_US.UTF-8

# Make sure we don't get notifications we can't answer during building.
ENV     DEBIAN_FRONTEND noninteractive

# Update the system
RUN     apt-get -q update && apt-mark hold initscripts udev plymouth mountall && apt-get -qy --force-yes dist-upgrade && apt-get install -qy python-software-properties software-properties-common
# Install transmission
RUN	add-apt-repository -y ppa:transmissionbt/ppa && apt-get update && apt-get install -y transmission-daemon

#Volume for configuration
VOLUME  /config
#Volume for media folders
VOLUME  /media/downloads

#Expose ports
EXPOSE  9091 51414

# Configure a localshop user
# Prepare user and group
RUN     addgroup --system downloads -gid 1001 && adduser --system --gecos downloads --shell /usr/sbin/nologin --uid 1001 --gid 1001 --disabled-password  downloads

# Clean up
RUN     apt-get -y autoclean && apt-get -y autoremove && apt-get clean && rm -rf /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/* && rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Add files, set permissions, ownership, create folders
ADD	start.sh /start.sh
RUN	mkdir -p /media/downloads/incomplete && mkdir -p /config && chown -R downloads: /media/downloads
ADD	settings.json /etc/transmission-daemon/
RUN	chown -R downloads: /config /etc/transmission-daemon/settings.json

# User which will run the doker's processes
USER	downloads

CMD	["/start.sh"]
