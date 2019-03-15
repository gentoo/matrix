# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="An implementation of the Double Ratchet cryptographic ratchet in C++"
HOMEPAGE="https://git.matrix.org/git/olm/about/"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.matrix.org/git/olm.git"
else
	SRC_URI="https://git.matrix.org/git/${PN}/snapshot/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0/$(ver_cut 1)"
IUSE=""

src_prepare() {
    default

    sed -i 's@$(PREFIX)@/usr@g' Makefile
}
