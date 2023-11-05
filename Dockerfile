# (c) Chris H. Meyer 2023
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

ARG ARCH

FROM docker.io/${ARCH}/debian:bookworm

RUN apt-get update && apt-get install -y \
        libsystemc \
        libsystemc-dev \
        gcc-riscv64-unknown-elf \
        openocd \
        make \
        git \
        wget \
        lbzip2 \
        gcc \
        bison \
        flex \
        bc \
        g++ \
        python3 \
        cmake \
        xz-utils \
    && apt-get clean

# Install ICSC
ENV ICSC_HOME=/opt/sc_tools
RUN git clone https://github.com/intel/systemc-compiler $ICSC_HOME/icsc \
        && CMAKE_BUILD_PARALLEL_LEVEL="" $ICSC_HOME/icsc/install.sh 

# Add entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root/paranut
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
