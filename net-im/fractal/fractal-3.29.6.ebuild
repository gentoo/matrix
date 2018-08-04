# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Matrix group messaging app"
HOMEPAGE="https://wiki.gnome.org/Apps/Fractal"

inherit meson xdg-utils gnome2-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.gnome.org/world/fractal.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://gitlab.gnome.org/World/fractal/uploads/bd30b8084b5f15c47d9fdc3049fe0515/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="dev-lang/rust
	>=app-text/gspell-1.8.1"
DEPEND="${RDEPEND}
    dev-util/ninja
    dev-util/meson
    dev-util/ninja
    dev-util/cargo"

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
