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

## Include headers
TARGET_SPECIFIC_HEADER_PATH := device/lge/p970/include

## inherit from the proprietary version
-include vendor/lge/p970/BoardConfigVendor.mk

## Board configuration
TARGET_BOARD_PLATFORM := omap3
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_PROVIDES_INIT_RC := true
TARGET_PROVIDES_INIT_TARGET_RC := true

## Device specific
OMAP_ENHANCEMENT := true
TARGET_BOOTLOADER_BOARD_NAME := p970
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3
BOARD_NEEDS_CUTILS_LOG := true
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
BOARD_SYSFS_LIGHT_SENSOR := "/sys/devices/platform/i2c_omap.2/i2c-2/2-0060/leds/lcd-backlight/als"

## Kernel
TARGET_PROVIDES_INIT_RC := true
TARGET_PROVIDES_INIT_TARGET_RC := true
BOARD_KERNEL_CMDLINE := 
BOARD_KERNEL_BASE := 0x80000000
BOARD_PAGE_SIZE := 0x00000800
TARGET_PREBUILT_KERNEL := device/lge/p970/prebuilt/kernel
BOARD_HAS_NO_SELECT_BUTTON := true

## BT
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

## Touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN := true

## USB
BOARD_USE_USB_MASS_STORAGE_SWITCH := true
BOARD_MTP_DEVICE := "/dev/mtp"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun0/file"

## Audio
BOARD_USES_AUDIO_LEGACY := true
BOARD_USES_GENERIC_AUDIO := false
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USE_KINETO_COMPATIBILITY := true

## OMX and Camera
HARDWARE_OMX := true
ifdef HARDWARE_OMX
ITTIAM_AUDIO := 1
ITTIAM_VIDEO := 1
BUILD_JPEG_DECODER := 1
BUILD_VPP := 1
BUILD_WITH_TI_AUDIO := 1
TARGET_OMX_WVGA_BUFFERS := true
BOARD_OMAP3_WITH_FFC := true
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
	hardware/ti/omap3/omx/system/src/openmax_il/omx_core/inc \
	hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

## Mobile data
BOARD_MOBILEDATA_INTERFACE_NAME := "vsnet0"

## WLAN
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_FW_PATH_STA         := "/system/etc/wifi/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP          := "/system/etc/wifi/fw_bcm4329_ap.bin"
WIFI_DRIVER_MODULE_NAME         := "wireless"
WIFI_DRIVER_MODULE_PATH         := "/system/lib/modules/wireless.ko"
WIFI_DRIVER_MODULE_ARG          := "firmware_path=/system/etc/wifi/fw_bcm4329.bin nvram_path=/system/etc/wifi/nvram.txt config_path=/data/misc/wifi/config"
WPA_SUPPLICANT_VERSION          := VER_0_6_X
WIFI_DRIVER_HAS_LGE_SOFTAP      := true
BOARD_WPA_SUPPLICANT_DRIVER	:= WEXT
BOARD_WEXT_NO_COMBO_SCAN	:= true

## EGL
BOARD_EGL_CFG := device/lge/p970/configs/egl.cfg
COMMON_GLOBAL_CFLAGS += -DSURFACEFLINGER_FORCE_SCREEN_RELEASE
USE_OPENGL_RENDERER := true
COMMON_GLOBAL_CFLAGS += -DOVERLAY_NUM_REQBUFFERS=6
TARGET_DISABLE_TRIPLE_BUFFERING := false
BOARD_ALLOW_EGL_HIBERNATION := true

## Images
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 665681920
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1170259968
BOARD_FLASH_BLOCK_SIZE := 131072

## Recovery
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/p970/recovery/graphics.c
BOARD_HAS_NO_MISC_PARTITION := true

## Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

## Charger
BOARD_GLOBAL_CFLAGS += -DCHARGERMODE_CMDLINE_NAME='"rs"' -DCHARGERMODE_CMDLINE_VALUE='"c"'

