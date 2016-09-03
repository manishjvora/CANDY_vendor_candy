# Inherit common candy stuff
$(call inherit-product, vendor/candy/config/common_full.mk)

# Required candy packages
PRODUCT_PACKAGES += \
    LatinIME

# Include candy LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/dictionaries

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

$(call inherit-product, vendor/candy/config/telephony.mk)
