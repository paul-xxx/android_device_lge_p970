#
# Copyright (C) 2013 BPaul
#

# inherit from the proprietary version
-include vendor/lge/p970/BoardConfigVendor.mk

TARGET_SPECIFIC_HEADER_PATH := device/lge/p970/include

# Kernel properties
TARGET_KERNEL_SOURCE := kernel/lge/p970
TARGET_KERNEL_CONFIG := on_ubuntu_p970_defconfig

# Kernel information
BOARD_KERNEL_CMDLINE := # This is ignored by lge's bootloader
BOARD_KERNEL_BASE := 0x80000000
BOARD_RECOVERY_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048

# Board configuration
TARGET_BOARD_PLATFORM := omap3
TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
OMAP_ENHANCEMENT := true
TARGET_BOOTLOADER_BOARD_NAME := p970
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# Light HAL
TARGET_PROVIDES_LIBLIGHTS := true

# Power HAL
TARGET_PROVIDES_POWERHAL := true

# FM
BOARD_HAVE_FM_RADIO := true

# Camera
# BOARD_USES_TI_CAMERA_HAL := true # Need improvement
HARDWARE_OMX := true
ifdef HARDWARE_OMX
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

# WLAN
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_FW_PATH_STA := "/system/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_MODULE_NAME := "wireless"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wireless.ko"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/firmware/fw_bcm4329.bin nvram_path=/system/etc/wifi/nvram.txt config_path=/data/misc/wifi/config"
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_wext
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WIFI_DRIVER_HAS_LGE_SOFTAP := true
BOARD_WPA_SUPPLICANT_DRIVER := WEXT

# Misc
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 665681920
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1170259968
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_NEEDS_CUTILS_LOG := true

# Display
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/lge/p970/configs/egl.cfg

# Recovery
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/p970/recovery/graphics.c
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"

# Vibrator fix
BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/p970/vibrator.c

# Enable compat with old blobs
COMMON_GLOBAL_CFLAGS += -DICS_AUDIO_BLOB -DICS_CAMERA_BLOB -DOMAP_ICS_CAMERA -DUSE_FENCE_SYNC

# ALS
BOARD_SYSFS_LIGHT_SENSOR := "/sys/devices/platform/omap/omap_i2c.2/i2c-2/2-0060/leds/lcd-backlight/als"

# Charger
COMMON_GLOBAL_CFLAGS += -DBOARD_CHARGING_CMDLINE_NAME='"rs"' -DBOARD_CHARGING_CMDLINE_VALUE='"c"'

# RIL fixes
BOARD_RIL_CLASS := ../../../device/lge/p970/ril/
BOARD_MOBILEDATA_INTERFACE_NAME := "vsnet0"

