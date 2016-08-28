# Inherit common Turbo stuff
$(call inherit-product, vendor/turbo/config/common_full.mk)

# Required Turbo packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Turbo LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/turbo/overlay/dictionaries

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/turbo/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
