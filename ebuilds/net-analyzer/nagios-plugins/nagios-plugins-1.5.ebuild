# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.4.16-r3.ebuild,v 1.2 2012/11/21 18:31:35 flameeyes Exp $

EAPI=4

PATCHSET=2

inherit autotools eutils multilib user

DESCRIPTION="Monitoring plugins - Pack of plugins to make Icinga, Naemon, Nagios, Shinken, Sensu work properly"
HOMEPAGE="http://www.monitoring-plugins.org"
SRC_URI="https://www.monitoring-plugins.org/download/${P}.tar.gz
	http://dev.gentoo.org/~flameeyes/${PN}/${PN}-1.4.16-patches-${PATCHSET}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="+ssl samba mysql postgres ldap snmp nagios-dns nagios-ntp nagios-ping nagios-ssh nagios-game ups ipv6 radius +suid jabber gnutls sudo smart"

DEPEND="ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	ssl? (
		!gnutls? ( dev-libs/openssl )
		gnutls? ( net-libs/gnutls )
	)
	radius? ( net-dialup/radiusclient )"

# tests try to ssh into the box itself
RESTRICT="test"

RDEPEND="${DEPEND}
	dev-lang/perl
	samba? ( net-fs/samba )
	snmp? ( dev-perl/Net-SNMP )
	mysql? ( dev-perl/DBI
			 dev-perl/DBD-mysql )
	nagios-dns? ( net-dns/bind-tools )
	nagios-ntp? ( net-misc/ntp )
	nagios-ping? ( net-analyzer/fping )
	nagios-ssh? ( net-misc/openssh )
	ups? ( sys-power/nut )
	nagios-game? ( games-util/qstat )
	jabber? ( dev-perl/Net-Jabber )
	sudo? ( app-admin/sudo )
	smart? ( sys-apps/smartmontools )"

REQUIRED_USE="smart? ( sudo )"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_prepare() {
	if use gnutls; then
	  epatch "${FILESDIR}"/gnutls_compatibility.patch
	fi
	
	epatch "${WORKDIR}"/patches/0003-configure-use-pg_config-to-find-where-to-find-Postgr.patch
	epatch "${WORKDIR}"/patches/0004-configure-don-t-expect-presence-of-127.0.0.1.patch

	eautoreconf
}

src_configure() {
	local myconf
	if use ssl; then
		myconf+="
			$(use_with !gnutls openssl /usr)
			$(use_with gnutls gnutls /usr)"
	else
		myconf+=" --without-openssl --without-gnutls"
	fi

	econf \
		$(use_with mysql) \
		$(use_with ipv6) \
		$(use_with ldap) \
		$(use_with radius) \
		$(use_with postgres pgsql /usr) \
		${myconf} \
		--disable-nls \
		--libexecdir=/usr/$(get_libdir)/nagios/plugins \
		--sysconfdir=/etc/nagios
}

DOCS=( ACKNOWLEDGEMENTS AUTHORS CODING ChangeLog FAQ LEGAL NEWS README REQUIREMENTS SUPPORT THANKS )

src_install() {
	default

	local nagiosplugindir=/usr/$(get_libdir)/nagios/plugins

	if use sudo; then
		cat - > "${T}"/50${PN} <<EOF
# we add /bin/false so that we don't risk causing syntax errors if all USE flags
# are off as we'd end up with an empty set
Cmnd_Alias NAGIOS_PLUGINS_CMDS = /bin/false $(use smart && echo ", /usr/sbin/smartctl")
User_Alias NAGIOS_PLUGINS_USERS = nagios, icinga

NAGIOS_PLUGINS_USERS ALL=(root) NOPASSWD: NAGIOS_PLUGINS_CMDS
EOF

		insinto /etc/sudoers.d
		doins "${T}"/50${PN}
	fi

	# enforce permissions/owners (seem to trigger only in some case)
	chown -R root:nagios "${D}${nagiosplugindir}" || die
	chmod -R o-rwx "${D}${nagiosplugindir}" || die

	use suid && fperms 04710 ${nagiosplugindir}/check_{icmp,ide_smart,dhcp}
}

pkg_postinst() {
	elog "This ebuild has a number of USE flags which determines what nagios is able to monitor."
	elog "Depending on what you want to monitor with nagios, some or all of these USE"
	elog "flags need to be set for nagios to function correctly."
}
