# Copyright (C) 2012 The Black Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/lge/p970/overlay

# Dummy file to help RM identify the model
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/dummy-rm:root/bootimages/ON_480x800_08fps_0000.rle

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/init.black.rc:root/init.black.rc \
    $(LOCAL_PATH)/prebuilt/init.black.usb.rc:root/init.black.usb.rc \
    $(LOCAL_PATH)/prebuilt/ueventd.black.rc:root/ueventd.black.rc \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# Radio fixes
FRAMEWORKS_BASE_SUBDIRS += ../../$(LOCAL_PATH)/ril/

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifimac/wlan-precheck:system/bin/wlan-precheck \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/nvram.txt:system/etc/wifi/nvram.txt \
    $(LOCAL_PATH)/configs/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Alsa configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/asound.conf:system/etc/asound.conf

# Charger mode
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# HAL Modules
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    power.p970 \
    hwcomposer.p970 \
    lights.p970 \
    prb \
    lgcpversion \
    wifimac

PRODUCT_PACKAGES += \
    libaudioutils \
    libtiutils \
    libion \
    libomap_mm_library_jni

# OMX components
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libbridge \
    cexec.out \
    libPERF \
    libOMX_Core \
    libLCML \
    libOMX.TI.Video.Decoder \
    libOMX.TI.Video.encoder \
    libOMX.TI.WBAMR.decode \
    libOMX.TI.AAC.encode \
    libOMX.TI.G722.decode \
    libOMX.TI.MP3.decode \
    libOMX.TI.WMA.decode \
    libOMX.TI.Video.encoder \
    libOMX.TI.WBAMR.encode \
    libOMX.TI.G729.encode \
    libOMX.TI.AAC.decode \
    libOMX.TI.VPP \
    libOMX.TI.G711.encode \
    libOMX.TI.JPEG.encoder \
    libOMX.TI.G711.decode \
    libOMX.TI.ILBC.decode \
    libOMX.TI.ILBC.encode \
    libOMX.TI.AMR.encode \
    libOMX.TI.G722.encode \
    libOMX.TI.JPEG.decoder \
    libOMX.TI.G726.encode \
    libOMX.TI.G729.decode \
    libOMX.TI.Video.Decoder \
    libOMX.TI.AMR.decode \
    libOMX.TI.G726.decode

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=20 \
    ro.sf.lcd_density=240 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    ro.media.enc.jpeg.quality=100 \
    ro.kernel.android.checkjni=0 \
    ro.hardware.respect_als=true \
    dalvik.vm.dexopt-data-only=1 \
    persist.sys.usb.config=mass_storage,adb \
    sys.mem.max_hidden_apps=5

# New charger images
PRODUCT_COPY_FILES += \
$(shell test -d $(LOCAL_PATH)/prebuilt/charger && find $(LOCAL_PATH)/prebuilt/charger -name '*.png' -printf '%p:root/res/images/charger/%f ')

$(call inherit-product, build/target/product/full.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

PRODUCT_AAPT_CONFIG := normal hdpi

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_p970
PRODUCT_DEVICE := p970
PRODUCT_MODEL := LG-P970
PRODUCT_MANUFACTURER := LGE
