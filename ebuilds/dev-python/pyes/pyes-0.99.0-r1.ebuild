# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit distutils

DESCRIPTION="Python Elastic Search driver"
HOMEPAGE="http://pypi.python.org/pypi/pyes/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/simplejson"
