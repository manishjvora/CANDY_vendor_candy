# We don't want more than nano
GAPPS_VARIANT := nano

# Define Gapps Packages
# Google Maps
PRODUCT_PACKAGES += \
        Maps

# Google Camera
PRODUCT_PACKAGES += \
        GoogleCamera

# Google Messenger
PRODUCT_PACKAGES += \
        PrebuiltBugle

# Google Chrome
GAPPS_FORCE_BROWSER_OVERRIDES := true

# Google Calculator
PRODUCT_PACKAGES += CalculatorGoogle

# Google Messenger
GAPPS_FORCE_MMS_OVERRIDES := true

# Google Music
PRODUCT_PACKAGES += \
        Music2

# Project Fi
PRODUCT_PACKAGES += \
        GCS \
        ProjectFi

# Google Calendar
PRODUCT_PACKAGES += \
	CalendarGooglePrebuilt

# Google Webview
PRODUCT_PACKAGES += \
	WebviewGoogle

# Exclude Google Package Installer and HotwordEnrollment
GAPPS_EXCLUDED_PACKAGES +=  \
        GooglePackageInstaller \
        Hotword

# include gapps
$(call inherit-product, vendor/google/build/opengapps-packages.mk)
