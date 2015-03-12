# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit pax-utils rpm versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="HP Smart Storage Administrator (HP SSA) CLI (HPSSACLI)"
HOMEPAGE="http://h20564.www2.hp.com/portal/site/hpsc/public/psi/home/?sp4ts.oid=5409020"
SRC_URI="
	amd64? ( http://downloads.linux.hp.com/SDR/repo/spp/RHEL/6/x86_64/current/${PN}-${MY_PV}.x86_64.rpm )
	x86? ( http://downloads.linux.hp.com/SDR/repo/spp/RHEL/6/i386/current/${PN}-${MY_PV}.i386.rpm )
"

LICENSE="hp-proliant-essentials"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	elibc_glibc? ( >sys-libs/glibc-2.14 )
	>=sys-libs/libunwind-0.99
	>=sys-process/procps-3.3.6
"

S="${WORKDIR}"
MY_S="${S}/opt/hp/hpssacli/bld"

HPSSACLI_BASEDIR="/opt/hp/hpssacli"

QA_PREBUILT="${HPSSACLI_BASEDIR:1}/hpssa*.bin"
QA_EXECSTACK="${HPSSACLI_BASEDIR:1}/hpssa*.bin"

src_prepare() {
	mv "${MY_S}"/hpssacli.license "${MY_S}"/license.txt || die "Renaming hpssacli.license failed!"
	mv "${MY_S}"/hpssacli*.txt "${MY_S}"/readme.txt || die "Renaming hpssacli*.txt failed!"
}

src_install() {
	newsbin "${FILESDIR}"/"${PN}-wrapper" ${PN}
	dosym ${PN} /usr/sbin/hpssascripting

	exeinto "${HPSSACLI_BASEDIR}"
	for bin in "${MY_S}"/hpssa{cli,scripting}; do
		local basename=$(basename "${bin}")
		newexe "${bin}" ${basename}.bin
	done

	dodoc "${MY_S}"/*.txt

	pax-mark m "${D}${HPSSACLI_BASEDIR}"/*.bin
}
