# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A glossy client for Matrix, written in QtQuick Controls 2 and C++."
HOMEPAGE="https://gitlab.com/b0/spectral"

inherit eutils xdg-utils gnome2-utils qmake-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.com/b0/spectral.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://gitlab.com/b0/spectral/-/archive/${PV}/${PN}.tar.gz -> ${P}.tar.gz"	
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-qt/qtgui
	dev-qt/qtmultimedia
	dev-qt/qtwidgets
	>dev-libs/libqmatrixclient-0.3.0.2"
DEPEND="${RDEPEND}
	dev-qt/qtcore"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
