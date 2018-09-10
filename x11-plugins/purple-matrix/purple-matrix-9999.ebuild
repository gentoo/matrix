# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Libpurple protocol plugin for matrix"
HOMEPAGE="https://github.com/matrix-org/purple-matrix"
EGIT_REPO_URI="https://github.com/matrix-org/purple-matrix.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="olm"

RDEPEND="net-im/pidgin
	dev-libs/glib
	dev-libs/json-glib
	net-libs/http-parser
	dev-db/sqlite:3
	olm? (
		dev-libs/olm
		dev-libs/libgcrypt:0
	)"
DEPEND="${RDEPEND}"

src_compile() {
	if use !olm; then
		export MATRIX_NO_E2E=1
	else
		# See https://github.com/matrix-org/purple-matrix/issues/83
		sed -i -e '/^LDLIBS+=-lolm/s/$/ -lgcrypt/' Makefile || die
	fi
	emake || die "Make failed!"
}
