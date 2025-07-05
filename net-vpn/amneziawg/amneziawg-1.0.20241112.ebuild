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
		einfo "Building for kernel ${KV_FULL}"
		local src_root=/usr/src/amneziawg-sources kv_patch="$KV_PATCH"
		while [ "${kv_patch}" -ge 1 ]; do
			local kv_full="${KV_MAJOR}.${KV_MINOR}.${kv_patch}${KV_LOCAL}"
			local src_full="${src_root}/${kv_full}"
			if [[ -d "${src_full}" ]]; then
				src_kernel="${src_full}"
				break
			fi
			kv_patch=$((kv_patch - 1))
		done
	fi
	local kernel_dir=src/kernel
	if [[ -n "${src_kernel}" ]]; then
		einfo "Using AmneziaWG kernel sources from ${src_kernel}"
		local wg_dir="${kernel_dir}"/drivers/net wg_name=wireguard
		mkdir -p "${wg_dir}"
		ln -s "${src_kernel}" "${wg_dir}"/"${wg_name}"
		ln -s "${KV_DIR}"/include "${kernel_dir}"/
	else
		einfo "Using kernel sources from ${KV_DIR}"
		ln -s "${KV_DIR}" "${kernel_dir}"
	fi
	local modargs=(KERNELRELEASE="${KV_FULL}")
	local modlist=(amneziawg=kernel/drivers/net:src:src:all)
	linux-mod-r1_src_compile
}
