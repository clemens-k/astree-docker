
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
RUN ln -fs /usr/share/zoneinfo/${TMZ} /etc/localtime && \
    dnf update -y && \
    dnf install -y epel-release && \
    crb enable && \
    dnf update -y && \
    dnf install -y glibc-langpack-en langpacks-en mc tar wget git chrpath vim-enhanced sudo \
                   perl-FindBin perl-Time-HiRes perl-XML-SAX perl-XML-Simple perl-XML-NamespaceSupport perl-XML-LibXML perl-DBD-MySQL perl-JSON perl-Sys-Hostname perl-Unicode-Normalize perl-IPC-Cmd perl-open perl-sigtrap perl-Capture-Tiny \
                   lsb_release gcc gcc-c++ glibc.i686 libstdc++.i686 zlib.i686 libnsl libnsl.i686 ncurses-compat-libs ncurses-devel \
                   autoconf automake gettext libtool make patch pkgconfig redhat-rpm-config rpm-build expect texinfo \
                   cups-devel openssl-devel glib2-devel libaio-devel pixman-devel expat-devel graphviz \
                   fontconfig-devel freetype-devel libICE-devel libSM-devel libX11-devel libXext-devel libXfixes-devel libXi-devel libXrender-devel mesa-libGL-devel \
                   libxcb-devel libxkbcommon-devel libxkbcommon-x11-devel wayland-devel wayland-protocols-devel \
                   xcb-util-devel xcb-util-image-devel xcb-util-renderutil-devel xcb-util-keysyms-devel xcb-util-wm-devel xcb-util-cursor-devel && \
    dnf clean all

# Create a user and group
RUN groupadd -r usergroup && useradd -r -g usergroup user

# Set permissions for the working directory
RUN mkdir /project && chown user:usergroup /project

# Switch to the new user
USER user

# Set working directory
WORKDIR /project
