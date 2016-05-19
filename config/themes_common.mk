# Theme engine
PRODUCT_PACKAGES += \
    aapt \
    ThemeChooser \
    ThemesProvider \
    tm

PRODUCT_COPY_FILES += \
    vendor/candy/prebuilt/etc/permissions/org.cyanogenmod.theme.xml:system/etc/permissions/org.cyanogenmod.theme.xml \
    vendor/candy/prebuilt/etc/permissions/com.tmobile.software.themes.xml:system/etc/permissions/com.tmobile.software.themes.xml
