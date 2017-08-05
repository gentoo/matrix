# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A glossy Matrix collaboration client for the web"
HOMEPAGE="https://riot.im"

inherit eutils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="git://github.com/vector-im/riot-web.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="https://github.com/vector-im/riot-web/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="abi_x86_32 abi_x86_64 websocket"
REQUIRED_USE="abi_x86_32? ( !abi_x86_64 )
			abi_x86_64? ( !abi_x86_32 )"

DEPEND="sys-devel/binutils
		net-libs/nodejs"
RDEPEND="${DEPEND}"

QA_PREBUILT="
		opt/Riot/libffmpeg.so
		opt/Riot/libnode.so
		opt/Riot/riot-web"

src_prepare() {
	default

	npm install

	pushd ${S}/node_modules/
	rm -rf matrix-js-sdk

	if use websocket; then
		git clone https://github.com/krombel/matrix-js-sdk --branch krombel_websockets
	else
		if [[ ${PV} == "9999" ]]; then
			git clone https://github.com/matrix-org/matrix-js-sdk --branch develop
		else
			git clone https://github.com/matrix-org/matrix-js-sdk
		fi
	fi

	pushd matrix-js-sdk
	npm install
	popd
	popd


	pushd ${S}/node_modules/
	rm -rf matrix-react-sdk

	if [[ ${PV} == "9999" ]]; then
		git clone https://github.com/matrix-org/matrix-react-sdk --branch develop
	else
		git clone https://github.com/matrix-org/matrix-react-sdk
	fi

	pushd matrix-react-sdk
	npm install
	popd
	popd

	cp ${S}/config.sample.json ${S}/config.json
}

src_compile() {
	npm run build

	if use abi_x86_32; then
		${S}/node_modules/.bin/build -l --ia32
	elif use abi_x86_64; then
		${S}/node_modules/.bin/build -l --x64
	fi
}

src_install() {
	ar x ${S}/electron_app/dist/riot-web*.deb
	tar xvf data.tar.xz

	insinto /
	doins -r usr
	doins -r opt
	fperms +x /opt/Riot/${PN}
	dosym /opt/Riot/${PN} /usr/bin/${PN}
}
