# Copyright 2025 RomikB
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Gentoo Kernel sources for AmneziaWG kernel module"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-linux-kernel-module"
SRC_URI="https://github.com/RomikB/gentoo-repository-deps/raw/main/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

src_install() {
	local install_dir=/usr/src/${PN}
	mkdir -p "${ED}${install_dir}" || die
	cp -R . "${ED}${install_dir}"/ || die
}
