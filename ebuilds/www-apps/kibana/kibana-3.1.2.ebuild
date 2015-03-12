# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit webapp

DESCRIPTION="visualize logs and time-stamped data"
HOMEPAGE="http://www.elasticsearch.org/overview/kibana/"
SRC_URI="https://download.elasticsearch.org/${PN}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="virtual/httpd-basic"

src_install() {
	webapp_src_preinst
	
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile  "${MY_HTDOCSDIR}"/config.js
	webapp_src_install
}
