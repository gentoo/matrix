# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Desktop client for the Matrix protocol"
HOMEPAGE="https://github.com/mujx/nheko"

inherit git-r3 eutils cmake-utils xdg-utils gnome2-utils

if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mujx/nheko.git"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=dev-qt/qtgui-5.7.1
		>=dev-qt/qtnetwork-5.7.1
		>=dev-qt/linguist-tools-5.7.1
		dev-qt/qtmultimedia
		media-libs/fontconfig
		dev-db/lmdb"
DEPEND="${RDEPEND}
		dev-util/ninja"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	emake DESTDIR="${D}"
}

src_install() {
	local icon_size
    for icon_size in 16 32 48 64 128 256 512; do
        newicon -s "${icon_size}" \
			"${S}/resources/nheko-${icon_size}.png" \
			nheko.png
    done

	domenu ${S}/resources/nheko.desktop

	dobin ${S}/build/nheko
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
