# Filename: Makefile
# Author: Olivier Sirol <czo@free.fr>
# License: GPL-2.0 (http://www.gnu.org/copyleft)
# File Created: 03 May 2024
# Last Modified: Thursday 13 June 2024, 15:32
# Edit Time: 2:53:11
# Description:
#
#        OpenWRT Makefile for muninwrt
#
# Copyright: (C) 2024 Olivier Sirol <czo@free.fr>

include $(TOPDIR)/rules.mk

PKG_NAME:=muninwrt
PKG_VERSION:=0.0.7
PKG_RELEASE:=1

PKG_MAINTAINER:=Olivier Sirol <czo@free.fr>
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

Build/Compile=

define Package/muninwrt
  SECTION:=utils
  CATEGORY:=Utilities
  PKGARCH:=all
  DEPENDS:=+xinetd +perl +perlbase-getopt +perlbase-file
  TITLE:=Munin node for OpenWRT implemented in perl like pmmn
  URL:=https://github.com/czodroid/muninwrt
endef

define Package/muninwrt/Default/description
  Munin node for OpenWRT implemented in perl like pmmn, with all plugins in /etc/munin/plugins.
  Munin is a monitoring system for Unix networks.
endef

define Package/muninwrt/install
	$(INSTALL_DIR)  $(1)/etc/xinetd.d
	$(INSTALL_CONF) ./files/etc/xinetd.d/muninwrt               $(1)/etc/xinetd.d/
	$(INSTALL_DIR)  $(1)/etc/munin
	$(INSTALL_BIN)  ./files/etc/munin/munin-pmmn                $(1)/etc/munin/munin-pmmn
	$(INSTALL_DIR)  $(1)/etc/munin/Munin
	$(INSTALL_DATA) ./files/etc/munin/Munin/Plugin.pm           $(1)/etc/munin/Munin/
	$(INSTALL_DIR)  $(1)/etc/munin/Munin/Common
	$(INSTALL_DATA) ./files/etc/munin/Munin/Common/Defaults.pm  $(1)/etc/munin/Munin/Common/
	$(INSTALL_DIR)  $(1)/etc/munin/plugins
	$(INSTALL_DATA) ./files/etc/munin/plugins/plugin.sh         $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/cpu               $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/df                $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/dfb               $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/forks             $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/if_br-lan         $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/if_err_br-lan     $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/if_err_eth0       $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/if_err_eth1       $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/if_eth0           $(1)/etc/munin/plugins/
	$(INSTALL_LN)  ./files/etc/munin/plugins/if_eth0           $(1)/etc/munin/plugins/if_eth1
	$(INSTALL_BIN)  ./files/etc/munin/plugins/interrupts        $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/irqstats          $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/load              $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/memory            $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/open_files        $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/open_inodes       $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/processes         $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/swap              $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/uptime            $(1)/etc/munin/plugins/
	$(INSTALL_BIN)  ./files/etc/munin/plugins/wireless          $(1)/etc/munin/plugins/
endef

define Package/muninwrt/conffiles
/etc/xinetd.d/muninwrt
endef

$(eval $(call BuildPackage,muninwrt))

