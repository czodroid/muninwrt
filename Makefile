# Filename: Makefile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 03 May 2024
# Last Modified: Sunday 15 February 2026, 20:18
# Edit Time: 3:32:19
# Description:
#
#        OpenWRT Makefile for muninwrt
#
# Copyright: (C) 2024-2026 Olivier Sirol <czo@free.fr>

include $(TOPDIR)/rules.mk

PKG_NAME:=muninwrt
PKG_VERSION:=1.0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=Olivier Sirol <czo@free.fr>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

Build/Compile=

define Package/muninwrt
  SECTION:=utils
  CATEGORY:=Utilities
  PKGARCH:=all
  DEPENDS:=+perl +perlbase-getopt +perlbase-file
  TITLE:=Munin node for OpenWRT implemented in perl like pmmn
  URL:=https://github.com/czodroid/muninwrt
endef

define Package/muninwrt/Default/description
  Munin is a monitoring system for Unix networks.
  Munin node for OpenWRT implemented in perl like pmmn, with all plugins in /etc/munin/plugins.
endef

define Package/muninwrt/install
    $(INSTALL_DIR)  $(1)/etc/munin
	$(CP) ./files/etc/munin/* $(1)/etc/munin/
endef

define Package/muninwrt/preinst
#!/bin/sh
echo "-> rm -fr ${IPKG_INSTROOT}/etc/munin"
rm -fr ${IPKG_INSTROOT}/etc/munin
endef

define Package/muninwrt/postinst
#!/bin/sh
echo "-> running munin-node-configure"
${IPKG_INSTROOT}/etc/munin/share/munin-node-configure
endef

define Package/muninwrt/postrm
#!/bin/sh
echo "-> rm -fr ${IPKG_INSTROOT}/etc/munin"
rm -fr ${IPKG_INSTROOT}/etc/munin
endef

$(eval $(call BuildPackage,muninwrt))

