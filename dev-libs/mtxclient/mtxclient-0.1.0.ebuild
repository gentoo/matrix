# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://github.com/mujx/mtxclient"

inherit eutils cmake-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/mujx/${PN}.git"
else
	SRC_URI="https://github.com/mujx/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"	
	#KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/spdlog
	dev-libs/libsodium
	>=dev-libs/boost-1.66.0
	dev-libs/olm"
DEPEND="${RDEPEND}"
