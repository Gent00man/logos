# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Jinja2 Command-Line Tool"
HOMEPAGE="https://github.com/kolypto/j2cli"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}-0.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=">=dev-python/jinja-2.7.2"

S="${WORKDIR}/${P}-0"

python_test() {
	esetup.py test
}
