# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Libpurple protocol plugin for matrix"
HOMEPAGE="https://github.com/matrix-org/purple-matrix"
EGIT_REPO_URI="https://github.com/matrix-org/purple-matrix.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="olm"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib
	dev-libs/json-glib
	net-im/pidgin
	net-libs/http-parser:=
	olm? (
		dev-libs/libgcrypt:0=
		dev-libs/olm:=
	)"
DEPEND="${RDEPEND}"

BDEPEND="
	virtual/pkgconfig
"

src_compile() {
	use olm || export MATRIX_NO_E2E=1
	emake || die "Make failed!"
}
