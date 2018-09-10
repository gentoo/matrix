# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Desktop client for the Matrix protocol"
HOMEPAGE="https://github.com/mujx/nheko"

inherit git-r3 eutils cmake-utils xdg-utils gnome2-utils

EGIT_REPO_URI="https://github.com/mujx/nheko.git"
if [[ ${PV} != "9999" ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=dev-qt/qtgui-5.7.1
		>=dev-qt/qtnetwork-5.7.1
		>=dev-qt/linguist-tools-5.7.1
		>=dev-qt/qtwidgets-5.7.0
		dev-qt/qtconcurrent
		dev-qt/qtmultimedia
		dev-qt/qtsvg
		media-libs/fontconfig
		dev-db/lmdb"
DEPEND="${RDEPEND}
		dev-util/ninja"

CMAKE_BUILD_TYPE=Release

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
