#
# Copyright (C) 2021 ImmortalWrt
# <https://project-openwrt.eu.org>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=speedtest-go
PKG_VERSION:=1.1.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/showwin/speedtest-go/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=08a5b139ca6b9068c717c21918aefa070e5e94403c092e00bf335de13c656611

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=hathlife <cjjmpgjjl.113@gmail.com>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/showwin/speedtest-go
GO_PKG_LDFLAGS:=-s -w

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/speedtest-go/config
config SPEEDTEST_GO_COMPRESS_UPX
	bool "Compress executable files with UPX"
	default n
endef

define Package/speedtest-go
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Self-contained Ookla speetest tool written in golang
	URL:=https://github.com/showwin/speedtest-go
	DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
endef

define Package/speedtest-go/description
	A self-contained Ookla speetest tool written in golang.
endef

define Build/Compile
	$(call GoPackage/Build/Compile)
ifneq ($(CONFIG_SPEEDTEST_GO_COMPRESS_UPX),)
	$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/speedtest-go
endif
endef

define Package/speedtest-go/install
	$(call GoPackage/Package/Install/Bin,$(1))
endef

$(eval $(call GoBinPackage,speedtest-go))
$(eval $(call BuildPackage,speedtest-go))
