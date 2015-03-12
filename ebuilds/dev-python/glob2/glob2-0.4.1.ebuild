# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Version of the glob module that can capture patterns and supports recursive wildcards"
HOMEPAGE="https://github.com/miracle2k/python-glob2/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

python_test() {
	esetup.py test
}
