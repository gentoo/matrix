# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

DESCRIPTION="Desktop client for the Matrix protocol"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/nheko/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/cmark
	dev-db/lmdb++
	>=dev-libs/mtxclient-0.3.1
	dev-libs/tweeny
	dev-qt/qtconcurrent
	dev-qt/qtdeclarative
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtmultimedia[qml,gstreamer]
	dev-qt/qtquickcontrols2
	dev-qt/qtsvg
	dev-qt/qtwidgets
	media-libs/fontconfig"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools
	dev-util/ninja"

CMAKE_BUILD_TYPE=Release

src_prepare() {
	sed -i '/-Werror/d' CMakeLists.txt || die
	cmake-utils_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
