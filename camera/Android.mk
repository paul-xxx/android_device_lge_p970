include $(all-subdir-makefiles)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_SRC_FILES:= \
    CameraHal.cpp \
    V4L2Camera.cpp \
    CameraHardware.cpp \
    converter.cpp \
    ExifCreator.cpp \

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/../include/ \
    frameworks/native/include/ui \
    frameworks/native/include/utils \
    frameworks/av/include/media/stagefright \
    frameworks/native/include/media/openmax \
    external/jpeg \
    external/jhead

LOCAL_SHARED_LIBRARIES:= \
    libui \
    libbinder \
    libutils \
    libcutils \
    libcamera_client \
    libcameraservice \
    libgui \
    libjpeg \
    libexif

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE:= camera.p970
LOCAL_MODULE_TAGS:= optional
LOCAL_WHOLE_STATIC_LIBRARIES:= libyuv

include $(BUILD_SHARED_LIBRARY)
include $(LOCAL_PATH)/Neon/android.mk
