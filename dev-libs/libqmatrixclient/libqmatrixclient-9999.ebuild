# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://github.com/qmatrixclient/libqmatrixclient"

inherit eutils cmake-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/qmatrixclient/${PN}.git"
else
	SRC_URI="https://gitlab.com/qmatrixclient/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"	
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-qt/qtcore"
