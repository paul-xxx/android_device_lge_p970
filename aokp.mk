## Specify phone tech before including full_phone
$(call inherit-product, vendor/aokp/config/gsm.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/aokp/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/p970/full_p970.mk)

# Release name and versioning
PRODUCT_RELEASE_NAME := Optimus Black
PRODUCT_VERSION_DEVICE_SPECIFIC :=

## Device identifier. This must come after all inclusions
PRODUCT_NAME := aokp_p970
PRODUCT_DEVICE := p970
PRODUCT_MODEL := LG-P970
