# Inherit full common LiquidRemix stuff
$(call inherit-product, vendor/venom/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
