# Common settings and files
-include vendor/candy/config/common.mk

# Add tablet overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/candy/overlay/common_tablet

PRODUCT_CHARACTERISTICS := tablet
