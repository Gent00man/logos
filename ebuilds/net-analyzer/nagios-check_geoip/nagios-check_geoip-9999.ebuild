# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 multilib

DESCRIPTION="Nagios checks for geoip database"
HOMEPAGE="https://github.com/hydrapolic/check_geoip"
EGIT_REPO_URI="https://github.com/hydrapolic/check_geoip.git"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
    exeinto /usr/$(get_libdir)/nagios/plugins
    doexe check_geoip
}
