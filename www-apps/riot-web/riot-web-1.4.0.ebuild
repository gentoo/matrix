# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A glossy Matrix collaboration client for the web"
HOMEPAGE="https://riot.im"

inherit eutils webapp

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/vector-im/riot-web.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="https://github.com/vector-im/riot-web/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
IUSE=""
REQUIRED_USE=""

DEPEND="sys-devel/binutils:*
	net-libs/nodejs
	sys-apps/yarn"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	if [[ ${PV} == "9999" ]]; then
		"${S}"/scripts/fetch-develop.deps.sh
	fi

	yarn install || die "Yarn module installation failed"
}

src_compile() {
	yarn run build || die "Build failed"
	yarn dist || die "Dist build failed"
}

src_install() {
	tar xfz "${S}/dist/riot-unknown.tar.gz" -C "${S}/dist"

	webapp_src_preinst
	insinto "${MY_HTDOCSDIR}"
	cd "${S}/dist/riot-unknown"
	doins -r .
	webapp_configfile "${MY_HTDOCSDIR}"/config.sample.json
	webapp_src_install
}
