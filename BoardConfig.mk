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

# Include headers
TARGET_SPECIFIC_HEADER_PATH := device/lge/p970/include
TARGET_BOARD_PLATFORM := omap3

# inherit from the proprietary version
-include vendor/lge/p970/BoardConfigVendor.mk

# Board configuration
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
OMAP_ENHANCEMENT := true

# Kernel/Bootloader machine name
TARGET_PROVIDES_INIT_RC := true
TARGET_PROVIDES_INIT_TARGET_RC := true
BOARD_KERNEL_CMDLINE := 
BOARD_KERNEL_BASE := 0x80000000
BOARD_PAGE_SIZE := 0x00000800
TARGET_PREBUILT_KERNEL := device/lge/p970/prebuilt/kernel
TARGET_BOOTLOADER_BOARD_NAME := p970
TARGET_NO_BOOTLOADER := true
BOARD_HAS_NO_SELECT_BUTTON := true

# HW Graphcis
BOARD_EGL_CFG := device/lge/p970/prebuilt/egl.cfg
COMMON_GLOBAL_CFLAGS += -DSURFACEFLINGER_FORCE_SCREEN_RELEASE
USE_OPENGL_RENDERER := true
TARGET_DISABLE_TRIPLE_BUFFERING := false
BOARD_ALLOW_EGL_HIBERNATION := true

# WLAN
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_FW_STA_PATH := "/system/etc/wifi/fw_bcm4329.bin"
WIFI_DRIVER_FW_AP_PATH := "/system/etc/wifi/fw_bcm4329_ap.bin"
WIFI_DRIVER_MODULE_NAME := "wireless"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wireless.ko"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/wifi/fw_bcm4329.bin nvram_path=/system/etc/wifi/nvram.txt config_path=/data/misc/wifi/config"
WPA_SUPPLICANT_VERSION := VER_0_6_X
WIFI_DRIVER_HAS_LGE_SOFTAP := true
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WEXT_NO_COMBO_SCAN := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# Touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN := true

# USB
BOARD_USE_USB_MASS_STORAGE_SWITCH := true
BOARD_MTP_DEVICE := "/dev/mtp"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun0/file"

# Mobile data
BOARD_MOBILEDATA_INTERFACE_NAME := "vsnet0"

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_AUDIO_LEGACY := true
BOARD_USES_AUDIO_LEGACY_HW := false
TARGET_PROVIDES_LIBAUDIO := true

# Camera
#BOARD_USES_TI_CAMERA_HAL := true
#FW3A := true
#ICAP := true
#IMAGE_PROCESSING_PIPELINE := true
#BOARD_CAMERA_FORCE_PREVIEWFORMAT := "yuv422i-yuyv"
#BOARD_USES_CAMERAID_PARAM := "video-input"
#USE_CAMERA_STUB := true
#BOARD_HAS_OMAP3_FW3A_LIBCAMERA := true

# OMX
HARDWARE_OMX := true
ifdef HARDWARE_OMX
BUILD_WITH_TI_AUDIO := 1
PERF_INSTRUMENTATION := 1
ITTIAM_AUDIO := 1
ITTIAM_VIDEO := 1
BUILD_JPEG_DECODER := 1
BUILD_VPP := 1
TARGET_OMX_WVGA_BUFFERS := true
BOARD_OMAP3_WITH_FFC := true
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
BOARD_CAMERA_LIBRARIES := libcamera
endif

ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3
endif

# Partitions configuration
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 665681920
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1170259968
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

COMMON_GLOBAL_CFLAGS += -DOVERLAY_NUM_REQBUFFERS=6

BOARD_GLOBAL_CFLAGS += -DCHARGERMODE_CMDLINE_NAME='"rs"' -DCHARGERMODE_CMDLINE_VALUE='"c"'
