# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit webapp

DESCRIPTION="A Composer proxy for speed and reliability"
HOMEPAGE="https://toranproxy.com"
SRC_URI="https://toranproxy.com/releases/${PN}-v${PV}.tgz"

LICENSE="GPL-3"
KEYWORDS="~amd64"

RDEPEND="virtual/httpd-php"

S="${WORKDIR}/toran"

src_install() {
	webapp_src_preinst
	
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install
}
