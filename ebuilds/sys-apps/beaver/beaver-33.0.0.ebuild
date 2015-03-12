# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 user

MY_PN="Beaver"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="python daemon that munches on logs and sends their contents to logstash"
HOMEPAGE="https://github.com/josegonzalez/beaver"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="redis"

DEPEND="dev-lang/python:2.7[sqlite]
	dev-python/conf_d
	dev-python/glob2
	dev-python/msgpack
	dev-python/python-daemon
	redis? ( dev-python/redis-py )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils-r1_src_install 

	keepdir /etc/beaver

	newinitd "${FILESDIR}"/beaver.initd beaver

	dodoc "${FILESDIR}"/logstash-redis.example
}

pkg_postinst() {
	elog
	elog "A sample configuration with connection to redis is in logstash-redis.example"
	elog "Check http://beaver.readthedocs.org/en/latest/user/usage.html#ssh-tunneling-support for SSH tunneling"
	elog
}
