# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg-utils

DESCRIPTION="Matrix group messaging app"
HOMEPAGE="https://wiki.gnome.org/Apps/Fractal"
SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RESTRICT="network-sandbox"

RDEPEND=">=app-text/gspell-1.8.1
	>=gui-libs/libhandy-0.0.9:0.0=
	media-libs/gstreamer-editing-services
	x11-libs/cairo
	x11-libs/gtksourceview:4"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/ninja
	dev-util/meson
	virtual/rust"

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
