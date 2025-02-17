# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 systemd toolchain-funcs

DESCRIPTION="Tools for configuring Amnezia-WG "
HOMEPAGE="https://github.com/amnezia-vpn/amneziawg-tools"
SRC_URI="https://github.com/amnezia-vpn/amneziawg-tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	emake RUNSTATEDIR="${EPREFIX}/run" -C src CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	dodoc README.md
	dodoc -r contrib
	emake \
		WITH_BASHCOMPLETION=yes \
		WITH_SYSTEMDUNITS=yes \
		WITH_WGQUICK=yes \
		DESTDIR="${D}" \
		BASHCOMPDIR="$(get_bashcompdir)" \
		SYSTEMDUNITDIR="$(systemd_get_systemunitdir)" \
		PREFIX="${EPREFIX}/usr" \
		-C src install
}
