# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="An API towards the Ubiquity Networks UniFi controller "
HOMEPAGE="https://github.com/calmh/unifi-api"
SRC_URI="https://github.com/calmh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( ${FILESDIR}/tls.patch )
