# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator

DESCRIPTION="A dependancy manager for PHP"
HOMEPAGE="http://getcomposer.org"

MY_PV=$(replace_version_separator _ -)

SRC_URI="http://getcomposer.org/download/${MY_PV}/composer.phar -> ${PN}-${MY_PV}.phar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.3.4"
RDEPEND="dev-lang/php[zip]"

src_unpack() {
	cp "${DISTDIR}/${A}" "${WORKDIR}"
	S=${WORKDIR}
}

src_install() {
	mv "${WORKDIR}/${A}" "${WORKDIR}/composer"
	dobin composer
}
