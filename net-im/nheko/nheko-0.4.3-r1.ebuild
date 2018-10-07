# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Desktop client for the Matrix protocol"
HOMEPAGE="https://github.com/mujx/nheko"

inherit eutils cmake-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mujx/nheko.git"
else
	SRC_URI="https://github.com/mujx/nheko/archive/v${PV}.tar.gz -> ${P}.tar.gz"	
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
