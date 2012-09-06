# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE_PACKAGE_OVERLAYS := device/lge/p970/overlay

# New APN's
PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/apns-conf.xml:system/etc/apns-conf.xml

# Initfs
PRODUCT_COPY_FILES += \
$(shell test -d device/lge/p970/prebuilt/chargerimages && find device/lge/p970/prebuilt/chargerimages -name '*.rle' -printf '%p:root/chargerimages/%f ') \
$(shell test -d device/lge/p970/prebuilt && find device/lge/p970/prebuilt -name '*.rc' -printf '%p:root/%f ') \
    $(LOCAL_PATH)/prebuilt/chargerlogo:root/sbin/chargerlogo \
    $(LOCAL_PATH)/prebuilt/g-recovery:root/sbin/g-recovery \
    $(LOCAL_PATH)/prebuilt/ON_480x800_08fps_0000.rle:root/bootimages/ON_480x800_08fps_0000.rle \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/vold.fstab:system/etc/vold.fstab

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Device specific
PRODUCT_PACKAGES += \
    gralloc.p970 \
    camera.p970 \
    lights.p970 \

#    hwcomposer.p970

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default

# Misc other modules
PRODUCT_PACKAGES += \
    libomap_mm_library_jni \
    libRS \
    librs_jni

# Wifi
PRODUCT_PACKAGES += wifimac

PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/wlan-precheck:system/bin/wlan-precheck

# Recovery
PRODUCT_PACKAGES += prb

# OpenMAX IL configuration
PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/media_profiles.xml:system/etc/media_profiles.xml \
    device/lge/p970/prebuilt/policytable.tbl:system/etc/policytable.tbl

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    com.ti.omap_enhancement=true

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
#$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor.mk)

# Include vendor non-open source blobs
#$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor-blobs.mk)
