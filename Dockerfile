FROM centos:7

MAINTAINER johannes bos

WORKDIR /usr/src

RUN curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz \
    && tar zxvf asterisk* \
    && rm *.tar.gz \
    && cd asterisk* \
    && ./contrib/scripts/install_prereq install \
    && ./configure --libdir=/usr/lib64 --with-pjproject-bundled \
    && make menuselect.makeopts \
    && ./menuselect/menuselect \
# CDR
    --disable-category MENUSELECT_CDR \
# CEL
    --disable-category MENUSELECT_CEL \
# CHANNELS
    --disable-category MENUSELECT_CHANNELS \
    --enable chan_bridge_media \
    --enable chan_pjsip \
    --enable chan_rtp \
# PBX
    --disable pbx_ael \
    --disable pbx_dundi \
    --disable pbx_lua \
    --disable pbx_realtime \
# RES
    --disable res_calendar \
    --disable res_calendar_exchange \
    --disable res_calendar_caldav \
    --disable res_calendar_ews \
    --disable res_calendar_icalendar \
    --disable res_fax \
    --disable res_fax_spandsp \
    --disable res_format_attr_celt \
    --disable res_format_attr_h263 \
    --disable res_format_attr_h264 \
    --disable res_format_attr_opus \
    --disable res_format_attr_silk \
    --disable res_digium_phone \
# CFLAGS
    --disable BUILD_NATIVE \
# CORE_SOUNDS
    --disable-category MENUSELECT_CORE_SOUNDS \
    --enable CORE-SOUNDS-EN-ALAW \
    --enable CORE-SOUNDS-EN-G722 \
# MOH
   --disable-category MENUSELECT_MOH \
   --enable MOH-OPSOUND-ALAW \
   --enable MOH-OPSOUND-G722 \
# EXTRA_SOUNDS
    --disable-category MENUSELECT_EXTRA_SOUNDS \
    menuselect.makeopts \    
    && make \ 
    && make install \
    && make config \
    && make distclean \
    && yum clean all \
    && rm -rf *

EXPOSE 5060/udp 10000-10099/udp

VOLUME /etc/asterisk /var/lib/asterisk/sounds /var/lib/asterisk/moh /var/log/asterisk

CMD ["/usr/sbin/asterisk", "-vvvvvvv"]
