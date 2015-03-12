# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

VARNISH_VERSION="${PV}"

inherit git-2

DESCRIPTION="This Varnish module exports functions to look up GeoIP country codes in VCL"
HOMEPAGE="https://github.com/lampeh/libvmod-geoip"

EGIT_REPO_URI="git://github.com/lampeh/libvmod-geoip.git"
EGIT_BRANCH="master"
SRC_URI="http://repo.varnish-cache.org/source/varnish-${VARNISH_VERSION}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE="doc"

DEPEND="
    doc? ( dev-python/docutils )
	dev-libs/geoip
	>=www-servers/varnish-3.0.6
	<www-servers/varnish-4
	"

RDEPEND="${DEPEND}"

VARNISH="${WORKDIR}/varnish-${VARNISH_VERSION}"
VMOD="${WORKDIR}/${P}"

src_prepare() {
	cd "${VARNISH}"
	econf
	emake

	if ! use doc; then
	  cd "${VMOD}"
	  epatch "${FILESDIR}/nodoc.patch"
	fi
}

src_compile() {
	cd ${VMOD}
	./autogen.sh
	econf VARNISHSRC=${VARNISH}
	emake
}

src_install() {
 	cd ${VMOD}
	emake DESTDIR="${D}" install
}
