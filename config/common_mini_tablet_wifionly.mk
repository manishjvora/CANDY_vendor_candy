# Inherit common candy stuff
$(call inherit-product, vendor/candy/config/common_mini.mk)

# Required candy packages
PRODUCT_PACKAGES += \
    LatinIME
