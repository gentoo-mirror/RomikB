# Copyright 2025 RomikB
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="AmneziaWG VPN protocol"
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-go"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-go/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/RomikB/gentoo-repository-deps/raw/main/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	emake
}
