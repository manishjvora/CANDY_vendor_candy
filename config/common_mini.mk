# Inherit common candy stuff
$(call inherit-product, vendor/candy/config/common.mk)

PRODUCT_SIZE := mini

# Include candy audio files
include vendor/candy/config/candy_audio.mk

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Helium.ogg

