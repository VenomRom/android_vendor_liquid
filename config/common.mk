\PRODUCT_BRAND ?=VenomRom

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Google property overides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.config.calibration_cad=/system/etc/calibration_cad.xml \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

# Security Enhanced Linux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Popcorn.ogg \
    ro.config.alarm_alert=Bright_morning.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
# Disable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# LatineIME Gesture swyping
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/venom/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/venom/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif

# Themes
PRODUCT_PACKAGES += \
    SettingsDarkTheme \
    SystemDarkTheme \
    SystemUIDarkTheme \
    SettingsBlackTheme \
    SystemBlackTheme \
    SystemUIBlackTheme

# QS tile styles
PRODUCT_PACKAGES += \
    QStileCircleTrim \
    QStileDefault \
    QStileDualToneCircle \
    QStileSquircleTrim

# Accents
PRODUCT_PACKAGES += \
    Amber \
    Black \
    Blue \
    BlueGrey \
    Brown \
    Cyan \
    DeepOrange \
    DeepPurple \
    Green \
    Grey \
    Indigo \
    LightBlue \
    LightGreen \
    Lime \
    Orange \
    Pink \
    Purple \
    Red \
    Teal \
    Yellow \
    White \
    UserOne \
    UserTwo \
    UserThree \
    UserFour \
    UserFive \
    UserSix \
    UserSeven

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/venom/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/venom/prebuilt/common/bin/50-liquid.sh:system/addon.d/50-liquid.sh \
    vendor/venom/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/venom/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/venom/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup services whitelist
PRODUCT_COPY_FILES += \
    vendor/venom/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# LiquidRemix specific init file
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/etc/init.local.rc:root/init.venom.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Google Dialer
PRODUCT_COPY_FILES +=  \
    vendor/venom/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml 

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Include LiquidRemix boot animation
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# AR
PRODUCT_COPY_FILES += \
    vendor/venom/prebuilt/common/etc/calibration_cad.xml:system/etc/calibration_cad.xml

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/venom/config/twrp.mk
endif

# Required packages
PRODUCT_PACKAGES += \
    Eleven \
    Email \
    Jelly \
    Launcher3

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker

PRODUCT_PACKAGES += \
    librsjni

# Omni packages
PRODUCT_PACKAGES += \
    OmniJaws

# Extra tools
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    powertop \
    tune2fs

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank
endif

# Prebuilt Apps
$(call inherit-product-if-exists, vendor/venom/prebuilt/common/prebuilt.mk)

# Vendor Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/venom/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/venom/overlay/common

# Version System
PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    VENOM_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    VENOM_VERSION_MAINTENANCE := 
endif

# Set VENOM_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef VENOM_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "LIQUID_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^VENOM_||g')
        VENOM_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE SNAPSHOT EXPERIMENTAL WEEKLY FINAL,$(VENOM_BUILDTYPE)),)
    VENOM_BUILDTYPE :=
endif

ifdef VENOM_BUILDTYPE
    ifneq ($(VENOM_BUILDTYPE), SNAPSHOT)
        ifdef VENOM_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            VENOM_BUILDTYPE := EXPERIMENTAL
            # Force build type to WEEKLY
            VENOM_BUILDTYPE := WEEKLY
            # Force build type to FINAL
            VENOM_BUILDTYPE := FINAL
            # Remove leading dash from VENOM_EXTRAVERSION
            VENOM_EXTRAVERSION := $(shell echo $(VENOM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to VENOM_EXTRAVERSION
            VENOM_EXTRAVERSION := -$(VENOM_EXTRAVERSION)
        endif
    else
        ifndef VENOM_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            VENOM_BUILDTYPE := EXPERIMENTAL
            # Force build type to WEEKLY, SNAPSHOT mandates a tag
            VENOM_BUILDTYPE := WEEKLY
            # Force build type to FINAL, SNAPSHOT mandates a tag
            VENOM_BUILDTYPE := FINAL
        else
            # Remove leading dash from VENOM_EXTRAVERSION
            VENOM_EXTRAVERSION := $(shell echo $(VENOM_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to VENOM_EXTRAVERSION
            VENOM_EXTRAVERSION := -$(VENOM_EXTRAVERSION)
        endif
    endif
else
    # If VENOM_BUILDTYPE is not defined, set to UNOFFICIAL
    VENOM_BUILDTYPE := UNOFFICIAL
    VENOM_EXTRAVERSION := 
endif

ifeq ($(VENOM_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        VENOM_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(VENOM_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-OFFICIAL-$(VENOM_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(VENOM_VERSION_MAINTENANCE),0)
                VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(VENOM_BUILD)
            else
                VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(VENOM_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(VENOMDBUILD)
            endif
        else
            VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(VENOM_BUILD)
        endif
    endif
else
    ifeq ($(VENOM_VERSION_MAINTENANCE),0)
        VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(VENOM_BUILDTYPE)$(VENOM_EXTRAVERSION)-$(VENOM_BUILD)
    else
        VENOM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(VENOM_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(VENOM_BUILDTYPE)$(VENOM_EXTRAVERSION)-$(VENOM_BUILD)
    endif
endif

TARGET_PRODUCT_SHORT := $(subst venom_,,$(VENOM_BUILDTYPE))

ROM_FINGERPRINT := VenomRom/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.venom.version=$(VENOM_VERSION) \
    ro.venom.releasetype=$(VENOM_BUILDTYPE) \
    ro.venom.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(VENOM_VERSION) \
    ro.venom.fingerprint=$(ROM_FINGERPRINT)

VENOM_DISPLAY_VERSION := $(VENOMVERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.venom.display.version=$(VENOM_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/venom/config/partner_gms.mk

$(call inherit-product-if-exists, vendor/extra/product.mk)
