# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib toolchain-funcs vcs-snapshot git-r3

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="https://github.com/conformal/spectrwm"
EGIT_REPO_URI="${CODEDIR}/${PN} ${MYGITHUB_URIBASE}${PN}.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
		x11-misc/dmenu
		!x11-wm/scrotwm
"
DEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/xcb-util
"

PATCHES=(
	"${FILESDIR}/${PF}-makefile.patch"
)


src_compile() {
	tc-export CC PKG_CONFIG
	emake -C linux PREFIX="${EROOT}/usr" LIBDIR="${EROOT}/usr/$(get_libdir)"
}

src_install() {

	emake -C linux PREFIX="${EROOT}/usr" LIBDIR="${EROOT}/usr/$(get_libdir)" \
		DESTDIR="${D}" install

	cd "${WORKDIR}"/${P} || die

	insinto /etc
	doins ${PN}.conf
	dodoc CHANGELOG.md README.md ${PN}_*.conf {initscreen,screenshot}.sh

	make_session_desktop ${PN} ${PN}

}
