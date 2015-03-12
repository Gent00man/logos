# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI="4"

inherit eutils webapp depend.php

DESCRIPTION="Web-based administration for Mongo database in PHP"
HOMEPAGE="http://www.rockmongo.com"
SRC_URI="https://github.com/iwind/rockmongo/archive/${PV}.zip"

LICENSE="BSD-2"
KEYWORDS="~amd64"

RDEPEND="
	dev-lang/php[session]
	dev-php/pecl-mongo
"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	dodoc CHANGELOG.txt INSTALL.txt LICENSE.txt README.txt || die

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_src_install
}

pkg_postinst() {
	elog "You can login with admin/admin credentials." 
	elog
	elog "Configure your RockMongo instance with config.php:"
	elog "http://www.rockmongo.com/wiki/configuration?lang=en_us"
}
