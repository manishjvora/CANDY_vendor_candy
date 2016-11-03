$(call inherit-product, vendor/candy/config/common.mk)

PRODUCT_PACKAGES += \
    LatinIME

PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/dictionaries

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/candy/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
