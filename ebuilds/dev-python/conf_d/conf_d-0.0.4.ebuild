# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="read configuration files, conf.d style"
HOMEPAGE="https://github.com/josegonzalez/python-conf_d"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

python_prepare() {
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -w -n conf_d/__init__.py || die
	fi
}
