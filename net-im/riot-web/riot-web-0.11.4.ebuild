# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A glossy Matrix collaboration client for the web"
HOMEPAGE="https://github.com/vector-im/riot-web"

inherit eutils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="git://github.com/vector-im/riot-web.git"
	EGIT_BRANCH="develop"
	EGIT_SDK_JS_URI="git://github.com/matrix-org/matrix-js-sdk"
	EGIT_SDK_REACT_URI="git://github.com/matrix-org/matrix-react-sdk"
else
	SRC_URI="https://github.com/vector-im/riot-web/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="-abi_x86_32 +abi_x86_64"
REQUIRED_USE="abi_x86_32? ( !abi_x86_64 )
			abi_x86_64? ( !abi_x86_32 )"

DEPEND="sys-devel/binutils
		net-libs/nodejs"
RDEPEND="${DEPEND}"

QA_PREBUILT="
		opt/Riot/libffmpeg.so
		opt/Riot/libnode.so
		opt/Riot/riot-web"

src_compile() {
	npm install

	if [[ ${PV} == "9999" ]]; then
		${S}/scripts/fetch-develop.deps.sh
	fi

	cp ${S}/config.sample.json ${S}/config.json

	npm run build

	if use abi_x86_32; then
		${S}/node_modules/.bin/build -l --ia32
	elif use abi_x86_64; then
		${S}/node_modules/.bin/build -l --x64
	fi
}

src_install() {
	local icon_size
    for icon_size in 16 24 48 64 96 128 256 512; do
        newicon -s "${icon_size}" \
			"${S}/electron_app/build/icons/${icon_size}x${icon_size}.png" \
			riot-web.png
    done

	#domenu ${S}/resources/nheko.desktop
	ar x ${S}/electron_app/dist/riot-web*.deb
	tar xvf data.tar.xz

	insinto /
	doins -r usr
	doins -r opt
	fperms +x /opt/Riot/${PN}
	dosym /opt/Riot/${PN} /usr/bin/${PN}
}
