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

DEPEND="sys-kernel/amneziawg-sources"

post_src_unpack() {
        mv "${WORKDIR}"/amneziawg-linux-kernel-module-* "${S}" || die
}

src_compile() {
        local kernel_dir=/usr/src/amneziawg-sources/"${KV_FULL}"
        ln -s "${kernel_dir}" src/kernel
        local modlist=(amneziawg=kernel/drivers/net:src:src:all)
        linux-mod-r1_src_compile
}
