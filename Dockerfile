FROM archlinux:latest

# install required packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm which expect openvpn dialog python-pip python-setuptools git dante && \
    pip install protonvpn-cli --break-system-packages

RUN pacman --noconfirm  -sS java | grep jdk && \
    pacman --noconfirm -S jdk-openjdk


COPY ./vpn-setup.exp ./config.sh /tmp/

ARG Mail
ARG PW


# protonvpn-cli needs access to width
ENV COLUMNS 80
ENV PROTONVPN_USER=${Mail}
ENV PROTONVPN_PASSWORD=${PW}
ENV PROTONVPN_PLAN=1
ENV PROTONVPN_PROTOCOL=2
ENV ProtonServer=${Server}

#RUN source /tmp/config.sh
RUN expect /tmp/vpn-setup.exp
RUN rm /tmp/vpn-setup.exp /tmp/config.sh
    
COPY ./sockd.conf /etc/

