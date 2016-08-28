# Inherit common Turbo stuff
$(call inherit-product, vendor/turbo/config/common_mini.mk)

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/turbo/prebuilt/common/bootanimation/800.zip:system/media/bootanimation.zip
endif
