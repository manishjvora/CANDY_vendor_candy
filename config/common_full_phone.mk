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

$(call inherit-product, vendor/turbo/config/telephony.mk)
