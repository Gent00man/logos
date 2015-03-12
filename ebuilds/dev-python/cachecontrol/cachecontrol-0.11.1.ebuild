# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="httplib2 caching for requests"
HOMEPAGE="https://github.com/ionrock/cachecontrol"
SRC_URI="https://github.com/ionrock/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="
	test? ( 
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/webtest[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-python/lockfile[${PYTHON_USEDEP}]
	)
	doc? ( 
		dev-python/sphinx 
	)"


python_test() {
	py.test || die "Tests fail with ${EPYTHON}"
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
