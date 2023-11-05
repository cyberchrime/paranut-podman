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


.PHONY=build clean

ARCH=$$(if [[ "$$(uname -m)" == "aarch64" ]]; then echo "arm64v8"; else echo "amd64"; fi)


all: build

build: paranut
	@podman build --build-arg=ARCH=$(ARCH) -t paranut:latest .
	@podman run -it --rm -v $$PWD/paranut:/root/paranut:Z paranut:latest

paranut:
	git clone https://github.com/hsa-ees/paranut.git
