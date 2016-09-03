PRODUCT_BRAND ?= candy

# Boot animation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.adb.secure=0

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/candy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/candy/prebuilt/common/bin/50-candy.sh:system/addon.d/50-candy.sh \
    vendor/candy/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/candy/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/candy/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# candy-specific init file
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/etc/init.local.rc:root/init.candy.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Required candy packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt

# Optional candy packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Custom candy packages
PRODUCT_PACKAGES += \
    Launcher3 \
    ExactCalculator \
    WallpaperPicker

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in candy
PRODUCT_PACKAGES += \
    libsepol \
    mke2fs \
    tune2fs \
    nano \
    htop \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace \
    pigz \
    su

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += vendor/candy/overlay/common

PRODUCT_VERSION_MAJOR = 6
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    CANDY_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    CANDY_VERSION_MAINTENANCE := 0
endif

# Set CANDY_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef CANDY_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "CANDY_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^CANDY_||g')
        CANDY_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY SNAPSHOT EXPERIMENTAL,$(CANDY_BUILDTYPE)),)
    CANDY_BUILDTYPE :=
endif

ifdef CANDY_BUILDTYPE
    ifneq ($(CANDY_BUILDTYPE), SNAPSHOT)
        ifdef CANDY_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            CANDY_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := -$(CANDY_EXTRAVERSION)
        endif
    else
        ifndef CANDY_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            CANDY_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to CANDY_EXTRAVERSION
            CANDY_EXTRAVERSION := -$(CANDY_EXTRAVERSION)
        endif
    endif
else
    # If CANDY_BUILDTYPE is not defined, set to UNOFFICIAL
    CANDY_BUILDTYPE := UNOFFICIAL
    CANDY_EXTRAVERSION :=
endif

ifeq ($(CANDY_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        CANDY_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(CANDY_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CANDY_BUILD)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(CANDY_VERSION_MAINTENANCE),0)
                CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CANDY_BUILD)
            else
                CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(CANDY_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CANDY_BUILD)
            endif
        else
            CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CANDY_BUILD)
        endif
    endif
else
    ifeq ($(CANDY_VERSION_MAINTENANCE),0)
        CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(CANDY_BUILDTYPE)$(CANDY_EXTRAVERSION)-$(CANDY_BUILD)
    else
        CANDY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(CANDY_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(CANDY_BUILDTYPE)$(CANDY_EXTRAVERSION)-$(CANDY_BUILD)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.candy.version=$(CANDY_VERSION) \
  ro.candy.releasetype=$(CANDY_BUILDTYPE) \
  ro.modversion=$(CANDY_VERSION)

-include vendor/candy-priv/keys/keys.mk

CANDY_DISPLAY_VERSION := $(CANDY_VERSION)

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(CANDY_BUILDTYPE), UNOFFICIAL)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(CANDY_EXTRAVERSION),)
        # Remove leading dash from CANDY_EXTRAVERSION
        CANDY_EXTRAVERSION := $(shell echo $(CANDY_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(CANDY_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    ifeq ($(CANDY_VERSION_MAINTENANCE),0)
        CANDY_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CANDY_BUILD)
    else
        CANDY_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(CANDY_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(CANDY_BUILD)
    endif
endif
endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.candy.display.version=$(CANDY_DISPLAY_VERSION)

-include $(WORKSPACE)/build_env/image-auto-bits.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
