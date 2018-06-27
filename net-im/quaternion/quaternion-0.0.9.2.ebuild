# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An IM client for the Matrix protocol"
HOMEPAGE="https://github.com/qmatrixclient/quaternion"

inherit git-r3 eutils cmake-utils

if [[ ${PV} != "9999" ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

EGIT_REPO_URI="https://github.com/qmatrixclient/quaternion.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-qt/qtgui-5.6.2
		>=dev-qt/qtdeclarative-5.6.2
		dev-qt/qtquickcontrols2"
RDEPEND="${DEPEND}"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
}
