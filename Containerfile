ARG DEBIAN_TAG=13.4

FROM docker.io/library/debian:${DEBIAN_TAG} AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install \
        git \
        build-essential \
        man \
        man-db \
        curl \
        python3 \
        pip \
        pipx \
        pandoc \
        imagemagick \
        ripgrep \
        fd-find \
        rsync \
        fzf \
        jq \
        bat \
        neovim \
        vim \
        sudo \
        less \
        eza \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN touch /etc/sudoers.d/01-no-password && \
    chmod u=rw,g=r,o=r /etc/sudoers.d/01-no-password && \
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/01-no-password

RUN groupadd wheel
RUN groupadd lug

RUN useradd -G wheel,lug -m gnuplususer
RUN useradd -G lug -m lugmember

RUN mkdir /lug && \
    chown root:lug /lug && \
    chmod u=rwx,g=rwxs,o= /lug
RUN touch /lug/for-lug-group && \
    chmod u=rw,g=rw,o= /lug/for-lug-group && \
    chown lugmember:lug /lug/for-lug-group

USER lugmember
WORKDIR /home/lugmember
RUN touch diary && \
    chmod u=rw,g=,o= diary

USER gnuplususer
WORKDIR /home/gnuplususer

RUN sed -i "s/alias ls='ls --color=auto'//" .bashrc

ENTRYPOINT bash
