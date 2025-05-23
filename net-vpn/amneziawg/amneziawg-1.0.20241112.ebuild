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

DEPEND="dist-kernel? ( sys-kernel/amneziawg-sources )"

PATCHES=( "${FILESDIR}/fix-apply-patches.patch" )

src_unpack() {
	default
	mv "${WORKDIR}"/amneziawg-linux-kernel-module-* "${S}" || die
}

src_compile() {
	local src_kernel
	if use dist-kernel; then
		local src_root=/usr/src/amneziawg-sources
		local src_full="${src_root}"/"${KV_FULL}" src_partial="${src_root}"/"${KV_MAJOR}.${KV_MINOR}${KV_LOCAL}"
		if [[ -d "${src_full}" ]]; then
			src_kernel="${src_full}"
		elif [[ -d "${src_partial}" ]]; then
			src_kernel="${src_partial}"
		fi
	fi
	local kernel_dir=src/kernel
	if [[ -n "${src_kernel}" ]]; then
		local wg_dir="${kernel_dir}"/drivers/net wg_name=wireguard
		mkdir -p "${wg_dir}"
		ln -s "${src_kernel}" "${wg_dir}"/"${wg_name}"
		ln -s "${KV_DIR}"/include "${kernel_dir}"/
	else
		ln -s "${KV_DIR}" "${kernel_dir}"
	fi
	local modargs=(KERNELRELEASE="${KV_FULL}")
	local modlist=(amneziawg=kernel/drivers/net:src:src:all)
	linux-mod-r1_src_compile
}
