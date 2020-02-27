Asterisk 13 Docker image

This image is based on Centos 7 and runs Asterisk 13

Please provide your own config via the /etc/asterisk volume.

Asterisk log files are written to /var/log/asterisk.

Alaw and g722 sounds & moh are included.
Use the /var/lib/asterisk/sounds volume if you want to provide your own sounds.
For own music on hold, use the /var/lib/asterisk/moh volume.

example docker-compose:
'''bash
version: "3"
services:
  asterisk13:
    image: johannesbos/asterisk13
    container_name: asterisk13
    volumes:
      - /docker/asterisk13/config:/etc/asterisk
      - /docker/asterisk13/log:/var/log/asterisk
#     - /docker/asterisk13/sounds:/var/lib/asterisk/sounds
#     - /docker/asterisk13/musiconhold:/var/lib/asterisk/moh
#   network_mode: host (Use network mode host if you want the complete RTP range (10000-10099)
    ports:
      - 5060:5060/udp
      - 10000:10000/udp
      - 10001:10001/udp
      - 10002:10002/udp
      - 10003:10003/udp
      - 10004:10004/udp
      - 10005:10005/udp
      - 10006:10006/udp
      - 10007:10007/udp
      - 10008:10008/udp
      - 10009:10009/udp
    restart: unless-stopped
'''
