# Inherit common Turbo stuff
$(call inherit-product, vendor/turbo/config/common.mk)

PRODUCT_SIZE := mini

# Include Turbo audio files
include vendor/turbo/config/turbo_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

