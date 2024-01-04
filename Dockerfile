#     _         _       ____    ____
#    / \   _ __(_) __ _|___ \  |  _ \ _ __ ___
#   / _ \ | '__| |/ _` | __) | | |_) | '__/ _ \
#  / ___ \| |  | | (_| |/ __/  |  __/| | | (_) |
# /_/   \_\_|  |_|\__,_|_____| |_|   |_|  \___/
#
# https://github.com/P3TERX/Aria2-Pro-Docker
#
# Copyright (c) 2020-2021 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.

FROM p3terx/s6-alpine

RUN apk add --no-cache jq findutils && \
    curl -fsSL git.io/aria2c.sh | bash && \
    rm -rf /var/cache/apk/* /tmp/*

RUN wget -O /config/OneDriveUploader https://raw.githubusercontent.com/rick-yao/OneList/master/OneDriveUploader/amd64/linux/OneDriveUploader
RUN chmod +x /config/OneDriveUploader
RUN pwd
RUN wget -O /config/script/uploader.sh https://raw.githubusercontent.com/rick-yao/someconf/main/aria2/uploader.sh
RUN chmod +x /config/scirpt/uploader.sh

COPY rootfs /

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1 \
    RCLONE_CONFIG=/config/rclone.conf \
    UPDATE_TRACKERS=true \
    CUSTOM_TRACKER_URL= \
    LISTEN_PORT=6888 \
    RPC_PORT=6800 \
    RPC_SECRET= \
    PUID= PGID= \
    DISK_CACHE= \
    IPV6_MODE= \
    UMASK_SET= \
    SPECIAL_MODE=

EXPOSE \
    6800 \
    6888 \
    6888/udp

VOLUME \
    /config \
    /downloads
