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

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Dalvik fix
PRODUCT_TAGS += dalvik.gc.type-precise
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# HDPI
PRODUCT_LOCALES += hdpi

# Framework overlay
DEVICE_PACKAGE_OVERLAYS += device/lge/p970/overlay

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/g-recovery:root/sbin/g-recovery \
    $(LOCAL_PATH)/prebuilt/init.lge.rc:root/init.lge.rc \
    $(LOCAL_PATH)/prebuilt/init.lge.usb.rc:root/init.lge.usb.rc \
    $(LOCAL_PATH)/prebuilt/init.rc:root/init.rc \
    $(LOCAL_PATH)/prebuilt/ueventd.lge.rc:root/ueventd.lge.rc \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
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
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# RIL and GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml \
    $(LOCAL_PATH)/configs/ipc_channels.config:system/etc/ipc_channels.config \
    $(LOCAL_PATH)/configs/init.vsnet:system/bin/init.vsnet

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifimac/wlan-precheck:system/bin/wlan-precheck \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/nvram.txt:system/etc/wifi/nvram.txt \
    $(LOCAL_PATH)/configs/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Media configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# HW Hal
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.usb.default \
    lights.hub \

# Other
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory \
    libaudioutils \
    hciattach \
    librs_jni \
    hcidump \
    hcitool \
    wifimac \
    prb

# OMX
PRODUCT_PACKAGES += \
    dspexec \
    libbridge \
    libLCML \
    libOMX_Core \
    libstagefrighthw \
    libOMX.TI.AAC.decode \
    libOMX.TI.AAC.encode \
    libOMX.TI.AMR.decode \
    libOMX.TI.AMR.encode \
    libOMX.TI.ILBC.decode \
    libOMX.TI.ILBC.encode \
    libOMX.TI.MP3.decode \
    libOMX.TI.MP3.encode \
    libOMX.TI.WBAMR.decode \
    libOMX.TI.WBAMR.encode \
    libOMX.TI.WMA.decode \
    libOMX.TI.WMA.encode \
    libOMX.TI.JPEG.decoder \
    libOMX.TI.JPEG.Encoder \
    libOMX.TI.Video.Decoder \
    libOMX.TI.Video.encoder

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
    ro.hardware.respect_als=true \
    dalvik.vm.dexopt-data-only=1 \
    sys.usb.state=mass_storage,adb \
    persist.sys.usb.config=mass_storage,adb

# Allow debug in GB ramdisk
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.allow.mock.location=1 \
    ro.debuggable=1 \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mass_storage,adb

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/lge/p970/p970-vendor.mk)
