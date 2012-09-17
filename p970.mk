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

# Include vendor non-open source blobs
$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor-blobs.mk)

# Screen density is actually considered a locale (since it is taken into account
# the the build-time selection of resources). The product definitions including
# this file must pay attention to the fact that the first entry in the final
# PRODUCT_LOCALES expansion must not be a density.
PRODUCT_LOCALES := hdpi

DEVICE_PACKAGE_OVERLAYS := device/lge/p970/overlay

# Dalvik VM
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Prebuilt copy
PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/media_codecs.xml:system/etc/media_codecs.xml \
    device/lge/p970/prebuilt/media_profiles.xml:system/etc/media_profiles.xml \
    device/lge/p970/prebuilt/vold.fstab:system/etc/vold.fstab

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# HW Packages
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    audio_policy.p970 \
    hwcomposer.default \
    camera.p970 \
    lights.p970

# JB sound
PRODUCT_PACKAGES += \
    hcitool hciattach hcidump \
    libaudioutils \
    libaudiohw_legacy

# Misc other modules
PRODUCT_PACKAGES += \
    libRS \
    librs_jni

# Other packages
PRODUCT_PACKAGES += \
    prb \
    com.android.future.usb.accessory

# OMX
PRODUCT_PACKAGES += \
    dspexec \
    libbridge \
    libOMX.TI.AAC.decode libOMX.TI.AAC.encode libOMX.TI.G711.decode \
    libOMX.TI.G711.encode libOMX.TI.G722.decode libOMX.TI.G722.encode \
    libOMX.TI.G726.decode libOMX.TI.G726.encode libOMX.TI.G729.decode \
    libOMX.TI.G729.encode libOMX.TI.ILBC.decode libOMX.TI.ILBC.encode \
    libOMX.TI.MP3.decode libOMX.TI.AMR.decode libOMX.TI.AMR.encode \
    libOMX.TI.WBAMR.decode libOMX.TI.WBAMR.encode libOMX.TI.WMA.decode \
    libOMX.TI.JPEG.decoder libOMX.TI.JPEG.Encoder libOMX.TI.VPP \
    libOMX.TI.Video.Decoder libOMX.TI.Video.encoder libLCML \
    libOMX_Core \
    libstagefrighthw

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
    wifi.supplicant_scan_interval=45 \
    ro.sf.lcd_density=240 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    ro.media.enc.jpeg.quality=100 \
    ro.kernel.android.checkjni=0 \
    sys.usb.state=mass_storage,adb \
    persist.sys.usb.config=mass_storage,adb

# Allow debug in GB ramdisk
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.allow.mock.location=1 \
    ro.debuggable=1 \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mass_storage,adb

PRODUCT_TAGS += dalvik.gc.type-precise

# Initfs
PRODUCT_COPY_FILES += \
$(shell test -d device/lge/p970/prebuilt/initramfs/chargerimages && find device/lge/p970/prebuilt/initramfs/chargerimages -name '*.rle' -printf '%p:root/chargerimages/%f ') \
    $(LOCAL_PATH)/prebuilt/initramfs/sbin/chargerlogo:root/sbin/chargerlogo \
    $(LOCAL_PATH)/prebuilt/initramfs/sbin/g-recovery:root/sbin/g-recovery \
    $(LOCAL_PATH)/prebuilt/initramfs/blink.sh:root/blink.sh \
    $(LOCAL_PATH)/prebuilt/initramfs/bootimage.rle:root/bootimages/ON_480x800_08fps_0000.rle \
    $(LOCAL_PATH)/prebuilt/initramfs/init:root/init \
    $(LOCAL_PATH)/prebuilt/initramfs/init.lge.rc:root/init.lge.rc \
    $(LOCAL_PATH)/prebuilt/initramfs/init.lge.usb.rc:root/init.lge.usb.rc \
    $(LOCAL_PATH)/prebuilt/initramfs/init.rc:root/init.rc \
    $(LOCAL_PATH)/prebuilt/initramfs/ueventd.lge.rc:root/ueventd.lge.rc

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor.mk)

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/lge/p970/prebuilt/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Audio copy
PRODUCT_COPY_FILES += \
    device/lge/p970/audio/audio_policy.conf:system/etc/audio_policy.conf

# Wlan copy
PRODUCT_COPY_FILES += \
    device/lge/p970/prebuilt/wlan/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/lge/p970/prebuilt/wlan/fw_bcm4329.bin:system/etc/wifi/fw_bcm4329.bin \
    device/lge/p970/prebuilt/wlan/fw_bcm4329_ap.bin:system/etc/wifi/fw_bcm4329_ap.bin \
    device/lge/p970/prebuilt/wlan/nvram.txt:system/etc/wifi/nvram.txt \
    device/lge/p970/prebuilt/wlan/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/lge/p970/prebuilt/wlan/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    device/lge/p970/prebuilt/wlan/wireless.ko:system/lib/modules/wireless.ko \
    device/lge/p970/prebuilt/wlan/wlan-precheck:system/bin/wlan-precheck
