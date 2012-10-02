# HWC under heavy development and should not be included in builds for now
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_PRELINK_MODULE := false
LOCAL_ARM_MODE := arm
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/../vendor/lib/hw
LOCAL_SHARED_LIBRARIES := liblog libEGL libcutils libutils libhardware libhardware_legacy
LOCAL_SRC_FILES := hwc.c

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := hwcomposer.omap3
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"ti_hwc\"

ifdef ENABLE_DEBUGING
LOCAL_CFLAGS += -DLOG_NDEBUG=0
endif

include $(BUILD_SHARED_LIBRARY)
