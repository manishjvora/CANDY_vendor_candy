# Inherit common Turbo stuff
$(call inherit-product, vendor/turbo/config/common_mini.mk)

# Required Turbo packages
PRODUCT_PACKAGES += \
    LatinIME
