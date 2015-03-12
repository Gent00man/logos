# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="check_geoip"
MY_P="${MY_PN}-${PV}"

inherit multilib

DESCRIPTION="Nagios checks for geoip database"
HOMEPAGE="https://github.com/hydrapolic/check_geoip"
SRC_URI="https://github.com/hydrapolic/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
    exeinto /usr/$(get_libdir)/nagios/plugins
    doexe check_geoip
}
