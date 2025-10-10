# Copyright 2025 RomikB
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="AmneziaWG Linux kernel module"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

src_unpack() {
	default
	mv "${WORKDIR}"/amneziawg-linux-kernel-module-* "${S}" || die
}

src_compile() {
	local modargs=(KERNELRELEASE="${KV_FULL}")
	local modlist=(amneziawg=kernel/drivers/net:src:src:all)
	linux-mod-r1_src_compile
}
