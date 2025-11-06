
FROM rockylinux/rockylinux:9

LABEL version="25.10"

ARG TMZ=Europe/Berlin
ENV TMZ=${TMZ}

# astree uses QT. Make sure QT uses offscreen platform as no GUI will be avialable in this docker container
ENV QT_QPA_PLATFORM=offscreen

# setup UTF-8 locale
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Make sure you set the AI_LICENSE_TLS environment, like docker run -e AI_LICENSE_TLS=your_astree_license_manager_url ...

# do one large transaction
# 1) fix the time zone
# 2) update
# 3) install the needed packages
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    dnf clean all && \
    dnf config-manager --set-enabled appstream && \
    dnf update -y && \
    dnf install -y epel-release && \
    crb enable && \
    dnf update -y && \
    dnf install -y --no-best \
      glibc-langpack-en langpacks-en mc tar wget git chrpath vim-enhanced sudo \
      xcb-util-devel xcb-util-image-devel xcb-util-renderutil-devel \
      xcb-util-keysyms-devel xcb-util-wm-devel xcb-util-cursor-devel && \
    dnf clean all

# Create a user and group
RUN groupadd -r usergroup && useradd -r -g usergroup user

# Set permissions for the working directory
RUN mkdir /project && chown user:usergroup /project

# Switch to the new user
USER user

# Set working directory
WORKDIR /project
