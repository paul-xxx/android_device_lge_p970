/*
 * Copyright (C) Texas Instruments - http://www.ti.com/
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



#ifndef ANDROID_HARDWARE_CAMERA_HARDWARE_H
#define ANDROID_HARDWARE_CAMERA_HARDWARE_H

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <utils/Log.h>
#include <utils/threads.h>
#include <linux/videodev2.h>
#include "binder/MemoryBase.h"
#include "binder/MemoryHeapBase.h"
#include <utils/threads.h>
#include <camera/CameraParameters.h>
#include <hardware/camera.h>
//#include "MessageQueue.h"
//#include "Semaphore.h"
//#include "CameraProperties.h"
//#include "DebugUtils.h"
//#include "SensorListener.h"

#include <ui/GraphicBufferAllocator.h>
#include <ui/GraphicBuffer.h>

#define MIN_WIDTH	640
#define MIN_HEIGHT	480
#define PICTURE_WIDTH   3280
#define PICTURE_HEIGHT  2464
#define PREVIEW_WIDTH	640
#define PREVIEW_HEIGHT	480
#define PIXEL_FORMAT	V4L2_PIX_FMT_YUV420

#define VIDEO_FRAME_COUNT_MAX    1 
#define MAX_CAMERA_BUFFERS    1 
#define MAX_ZOOM        3
#define THUMB_WIDTH     80
#define THUMB_HEIGHT    60
#define PIX_YUV422I 0
#define PIX_YUV420P 1

#define SATURATION_OFFSET 100
#define SHARPNESS_OFFSET 100
#define CONTRAST_OFFSET 100

#define CAMHAL_GRALLOC_USAGE GRALLOC_USAGE_HW_TEXTURE | \
                             GRALLOC_USAGE_HW_RENDER | \
                             GRALLOC_USAGE_SW_READ_RARELY | \
                             GRALLOC_USAGE_SW_WRITE_NEVER

#define PPM_INSTRUMENTATION_ABS 1

#define LOCK_BUFFER_TRIES 5
#define HAL_PIXEL_FORMAT_NV12 0x100

#define CAMHAL_LOGI LOGI

#define DEBUG_LOG

#ifndef DEBUG_LOG

#define CAMHAL_LOGDA(str)
#define CAMHAL_LOGDB(str, ...)
#define CAMHAL_LOGVA(str)
#define CAMHAL_LOGVB(str, ...)

#define CAMHAL_LOGEA LOGE
#define CAMHAL_LOGEB LOGE

#undef LOG_FUNCTION_NAME
#undef LOG_FUNCTION_NAME_EXIT
#define LOG_FUNCTION_NAME
#define LOG_FUNCTION_NAME_EXIT

#else

#undef LOG_FUNCTION_NAME
#undef LOG_FUNCTION_NAME_EXIT
#define __FILENAME__ strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__
#define LOG_FUNCTION_NAME LOGE("++++Entering %s:%s", __FILENAME__, __FUNCTION__)
#define LOG_FUNCTION_NAME_EXIT LOGE("----Exiting %s:%s",__FILENAME__, __FUNCTION__)

#define CAMHAL_LOGDA DBGUTILS_LOGDA
#define CAMHAL_LOGDB DBGUTILS_LOGDB
#define CAMHAL_LOGVA DBGUTILS_LOGVA
#define CAMHAL_LOGVB DBGUTILS_LOGVB

#define CAMHAL_LOGEA DBGUTILS_LOGEA
#define CAMHAL_LOGEB DBGUTILS_LOGEB

#endif



#define NONNEG_ASSIGN(x,y) \
    if(x > -1) \
        y = x

namespace android {

#define PARAM_BUFFER            6000

///Forward declarations
class CameraHal;
class CameraFrame;
class CameraHalEvent;
class DisplayFrame;

class CameraArea : public RefBase
{
public:

    CameraArea(ssize_t top,
               ssize_t left,
               ssize_t bottom,
               ssize_t right,
               size_t weight) : mTop(top),
                                mLeft(left),
                                mBottom(bottom),
                                mRight(right),
                                mWeight(weight) {}

    status_t transfrom(size_t width,
                       size_t height,
                       size_t &top,
                       size_t &left,
                       size_t &areaWidth,
                       size_t &areaHeight);

    bool isValid()
        {
        return ( ( 0 != mTop ) || ( 0 != mLeft ) || ( 0 != mBottom ) || ( 0 != mRight) );
        }

    bool isZeroArea()
    {
        return  ( (0 == mTop ) && ( 0 == mLeft ) && ( 0 == mBottom )
                 && ( 0 == mRight ) && ( 0 == mWeight ));
    }

    size_t getWeight()
        {
        return mWeight;
        }

    bool compare(const sp<CameraArea> &area);

    static status_t parseAreas(const char *area,
                               size_t areaLength,
                               Vector< sp<CameraArea> > &areas);

    static status_t checkArea(ssize_t top,
                              ssize_t left,
                              ssize_t bottom,
                              ssize_t right,
                              ssize_t weight);

    static bool areAreasDifferent(Vector< sp<CameraArea> > &, Vector< sp<CameraArea> > &);

protected:
    static const ssize_t TOP = -1000;
    static const ssize_t LEFT = -1000;
    static const ssize_t BOTTOM = 1000;
    static const ssize_t RIGHT = 1000;
    static const ssize_t WEIGHT_MIN = 1;
    static const ssize_t WEIGHT_MAX = 1000;

    ssize_t mTop;
    ssize_t mLeft;
    ssize_t mBottom;
    ssize_t mRight;
    size_t mWeight;
};

class CameraFDResult : public RefBase
{
public:

    CameraFDResult() : mFaceData(NULL) {};
    CameraFDResult(camera_frame_metadata_t *faces) : mFaceData(faces) {};

    virtual ~CameraFDResult() {
        if ( ( NULL != mFaceData ) && ( NULL != mFaceData->faces ) ) {
            free(mFaceData->faces);
            free(mFaceData);
            mFaceData=NULL;
        }

        if(( NULL != mFaceData ))
            {
            free(mFaceData);
            mFaceData = NULL;
            }
    }

    camera_frame_metadata_t *getFaceResult() { return mFaceData; };

    static const ssize_t TOP = -1000;
    static const ssize_t LEFT = -1000;
    static const ssize_t BOTTOM = 1000;
    static const ssize_t RIGHT = 1000;
    static const ssize_t INVALID_DATA = -2000;

private:

    camera_frame_metadata_t *mFaceData;
};

class CameraFrame
{
    public:

    enum FrameType
        {
            PREVIEW_FRAME_SYNC = 0x1,
            PREVIEW_FRAME = 0x2,
            IMAGE_FRAME_SYNC = 0x4,
            IMAGE_FRAME = 0x8,
            VIDEO_FRAME_SYNC = 0x10,
            VIDEO_FRAME = 0x20,
            FRAME_DATA_SYNC = 0x40,
            FRAME_DATA= 0x80,
            RAW_FRAME = 0x100,
            SNAPSHOT_FRAME = 0x200,
            ALL_FRAMES = 0xFFFF
        };

    enum FrameQuirks
    {
        ENCODE_RAW_YUV422I_TO_JPEG = 0x1 << 0,
        HAS_EXIF_DATA = 0x1 << 1,
    };

    CameraFrame():
    mCookie(NULL),
    mCookie2(NULL),
    mBuffer(NULL),
    mFrameType(0),
    mTimestamp(0),
    mWidth(0),
    mHeight(0),
    mOffset(0),
    mAlignment(0),
    mFd(0),
    mLength(0),
    mFrameMask(0),
    mQuirks(0) {

      mYuv[0] = NULL;
      mYuv[1] = NULL;
    }

    CameraFrame(const CameraFrame &frame) :
    mCookie(frame.mCookie),
    mCookie2(frame.mCookie2),
    mBuffer(frame.mBuffer),
    mFrameType(frame.mFrameType),
    mTimestamp(frame.mTimestamp),
    mWidth(frame.mWidth),
    mHeight(frame.mHeight),
    mOffset(frame.mOffset),
    mAlignment(frame.mAlignment),
    mFd(frame.mFd),
    mLength(frame.mLength),
    mFrameMask(frame.mFrameMask),
    mQuirks(frame.mQuirks) {

      mYuv[0] = frame.mYuv[0];
      mYuv[1] = frame.mYuv[1];
    }

    void *mCookie;
    void *mCookie2;
    void *mBuffer;
    int mFrameType;
    nsecs_t mTimestamp;
    unsigned int mWidth, mHeight;
    uint32_t mOffset;
    unsigned int mAlignment;
    int mFd;
    size_t mLength;
    unsigned mFrameMask;
    unsigned int mQuirks;
    unsigned int mYuv[2];
};

enum CameraHalError
{
    CAMERA_ERROR_FATAL = 0x1,
    CAMERA_ERROR_HARD = 0x2,
    CAMERA_ERROR_SOFT = 0x4,
};

class CameraHalEvent
{
public:

    enum CameraHalEventType {
        NO_EVENTS = 0x0,
	EVENT_FOCUS_LOCKED = 0x1,
	EVENT_FOCUS_ERROR = 0x2,
	EVENT_ZOOM_INDEX_REACHED = 0x4,
        EVENT_SHUTTER = 0x8,
        EVENT_FACE = 0x10,
        ALL_EVENTS = 0xFFFF
    };

    typedef struct ShutterEventData_t {
        bool shutterClosed;
    }ShutterEventData;

    typedef struct FocusEventData_t {
        bool focusLocked;
        bool focusError;
        int currentFocusValue;
    } FocusEventData;

    typedef struct ZoomEventData_t {
        int currentZoomIndex;
        bool targetZoomIndexReached;
    } ZoomEventData;

    typedef struct FaceData_t {
        ssize_t top;
        ssize_t left;
        ssize_t bottom;
        ssize_t right;
        size_t score;
    } FaceData;

    typedef sp<CameraFDResult> FaceEventData;

    class CameraHalEventData : public RefBase{

    public:

        CameraHalEvent::FocusEventData focusEvent;
        CameraHalEvent::ZoomEventData zoomEvent;
        CameraHalEvent::ShutterEventData shutterEvent;
        CameraHalEvent::FaceEventData faceEvent;
    };
    CameraHalEvent():
    mCookie(NULL),
    mEventType(NO_EVENTS) {}

    CameraHalEvent(const CameraHalEvent &event) :
        mCookie(event.mCookie),
        mEventType(event.mEventType),
        mEventData(event.mEventData) {};

    void* mCookie;
    CameraHalEventType mEventType;
    sp<CameraHalEventData> mEventData;

};

typedef void (*frame_callback) (CameraFrame *cameraFrame);
typedef void (*event_callback) (CameraHalEvent *event);

typedef void (*release_image_buffers_callback) (void *userData);
typedef void (*end_image_capture_callback) (void *userData);

class MessageNotifier
{
public:
    static const uint32_t EVENT_BIT_FIELD_POSITION;
    static const uint32_t FRAME_BIT_FIELD_POSITION;

    virtual void enableMsgType(int32_t msgs, frame_callback frameCb=NULL, event_callback eventCb=NULL, void* cookie=NULL) = 0;
    virtual void disableMsgType(int32_t msgs, void* cookie) = 0;

    virtual ~MessageNotifier() {};
};

class ErrorNotifier : public virtual RefBase
{
public:
    virtual void errorNotify(int error) = 0;

    virtual ~ErrorNotifier() {};
};

class FrameNotifier : public MessageNotifier
{
public:
    virtual void returnFrame(void* frameBuf, CameraFrame::FrameType frameType) = 0;
    virtual void addFramePointers(void *frameBuf, void *buf) = 0;
    virtual void removeFramePointers() = 0;

    virtual ~FrameNotifier() {};
};

class FrameProvider
{
    FrameNotifier* mFrameNotifier;
    void* mCookie;
    frame_callback mFrameCallback;

public:
    FrameProvider(FrameNotifier *fn, void* cookie, frame_callback frameCallback)
        :mFrameNotifier(fn), mCookie(cookie),mFrameCallback(frameCallback) { }

    int enableFrameNotification(int32_t frameTypes);
    int disableFrameNotification(int32_t frameTypes);
    int returnFrame(void *frameBuf, CameraFrame::FrameType frameType);
    void addFramePointers(void *frameBuf, void *buf);
    void removeFramePointers();
};

class EventProvider
{
public:
    MessageNotifier* mEventNotifier;
    void* mCookie;
    event_callback mEventCallback;

public:
    EventProvider(MessageNotifier *mn, void* cookie, event_callback eventCallback)
        :mEventNotifier(mn), mCookie(cookie), mEventCallback(eventCallback) {}

    int enableEventNotification(int32_t eventTypes);
    int disableEventNotification(int32_t eventTypes);
};

class BufferProvider
{
public:
    virtual void* allocateBuffer(int width, int height, const char* format, int &bytes, int numBufs) = 0;

    virtual uint32_t * getOffsets() = 0;
    virtual int getFd() = 0;

    virtual int freeBuffer(void* buf) = 0;

    virtual ~BufferProvider() {}
};

class   AppCallbackNotifier: public ErrorNotifier , public virtual RefBase
{

public:

    static const int NOTIFIER_TIMEOUT;
    static const int32_t MAX_BUFFERS = 8;

    enum NotifierCommands
        {
        NOTIFIER_CMD_PROCESS_EVENT,
        NOTIFIER_CMD_PROCESS_FRAME,
        NOTIFIER_CMD_PROCESS_ERROR
        };

    enum NotifierState
        {
        NOTIFIER_STOPPED,
        NOTIFIER_STARTED,
        NOTIFIER_EXITED
        };

public:

    ~AppCallbackNotifier();

    status_t initialize();

    status_t start();

    status_t stop();

    void setEventProvider(int32_t eventMask, MessageNotifier * eventProvider);
    void setFrameProvider(FrameNotifier *frameProvider);

    virtual void errorNotify(int error);

    status_t startPreviewCallbacks(CameraParameters &params, void *buffers, uint32_t *offsets, int fd, size_t length, size_t count);
    status_t stopPreviewCallbacks();

    status_t enableMsgType(int32_t msgType);
    status_t disableMsgType(int32_t msgType);

    void setMeasurements(bool enable);

    bool notificationThread();

    static void frameCallbackRelay(CameraFrame* caFrame);
    static void eventCallbackRelay(CameraHalEvent* chEvt);
    void frameCallback(CameraFrame* caFrame);
    void eventCallback(CameraHalEvent* chEvt);
    void flushAndReturnFrames();

    void setCallbacks(CameraHal *cameraHal,
                        camera_notify_callback notify_cb,
                        camera_data_callback data_cb,
                        camera_data_timestamp_callback data_cb_timestamp,
                        camera_request_memory get_memory,
                        void *user);

    void setBurst(bool burst);

    status_t startRecording();
    status_t stopRecording();
    status_t initSharedVideoBuffers(void *buffers, uint32_t *offsets, int fd, size_t length, size_t count, void *vidBufs);
    status_t releaseRecordingFrame(const void *opaque);

	status_t useMetaDataBufferMode(bool enable);

    void EncoderDoneCb(void*, void*, CameraFrame::FrameType type, void* cookie1, void* cookie2);

    void useVideoBuffers(bool useVideoBuffers);

    bool getUesVideoBuffers();
    void setVideoRes(int width, int height);

    void flushEventQueue();

    class NotificationThread : public Thread {
        AppCallbackNotifier* mAppCallbackNotifier;
        TIUTILS::MessageQueue mNotificationThreadQ;
    public:
        enum NotificationThreadCommands
        {
        NOTIFIER_START,
        NOTIFIER_STOP,
        NOTIFIER_EXIT,
        };
    public:
        NotificationThread(AppCallbackNotifier* nh)
            : Thread(false), mAppCallbackNotifier(nh) { }
        virtual bool threadLoop() {
            return mAppCallbackNotifier->notificationThread();
        }

        TIUTILS::MessageQueue &msgQ() { return mNotificationThreadQ;}
    };
    friend class NotificationThread;

private:
    void notifyEvent();
    void notifyFrame();
    bool processMessage();
    void releaseSharedVideoBuffers();
    status_t dummyRaw();
    void copyAndSendPictureFrame(CameraFrame* frame, int32_t msgType);
    void copyAndSendPreviewFrame(CameraFrame* frame, int32_t msgType);

private:
    mutable Mutex mLock;
    mutable Mutex mBurstLock;
    CameraHal* mCameraHal;
    camera_notify_callback mNotifyCb;
    camera_data_callback   mDataCb;
    camera_data_timestamp_callback mDataCbTimestamp;
    camera_request_memory mRequestMemory;
    void *mCallbackCookie;

    KeyedVector<unsigned int, unsigned int> mVideoHeaps;
    KeyedVector<unsigned int, unsigned int> mVideoBuffers;
    KeyedVector<unsigned int, unsigned int> mVideoMap;

    KeyedVector<uint32_t, uint32_t> mVideoMetadataBufferMemoryMap;
    KeyedVector<uint32_t, uint32_t> mVideoMetadataBufferReverseMap;

    bool mBufferReleased;

    sp< NotificationThread> mNotificationThread;
    EventProvider *mEventProvider;
    FrameProvider *mFrameProvider;
    TIUTILS::MessageQueue mEventQ;
    TIUTILS::MessageQueue mFrameQ;
    NotifierState mNotifierState;

    bool mPreviewing;
    camera_memory_t* mPreviewMemory;
    unsigned char* mPreviewBufs[MAX_BUFFERS];
    int mPreviewBufCount;
    const char *mPreviewPixelFormat;
    KeyedVector<unsigned int, sp<MemoryHeapBase> > mSharedPreviewHeaps;
    KeyedVector<unsigned int, sp<MemoryBase> > mSharedPreviewBuffers;

    bool mBurst;
    mutable Mutex mRecordingLock;
    bool mRecording;
    bool mMeasurementEnabled;

    bool mUseMetaDataBufferMode;
    bool mRawAvailable;

    bool mUseVideoBuffers;

    int mVideoWidth;
    int mVideoHeight;

};

class MemoryManager : public BufferProvider, public virtual RefBase
{
public:
    MemoryManager():mIonFd(0){ }

    status_t initialize() { return NO_ERROR; }

    int setErrorHandler(ErrorNotifier *errorNotifier);
    virtual void* allocateBuffer(int width, int height, const char* format, int &bytes, int numBufs);
    virtual uint32_t * getOffsets();
    virtual int getFd() ;
    virtual int freeBuffer(void* buf);

private:

    sp<ErrorNotifier> mErrorNotifier;
    int mIonFd;
    KeyedVector<unsigned int, unsigned int> mIonHandleMap;
    KeyedVector<unsigned int, unsigned int> mIonFdMap;
    KeyedVector<unsigned int, unsigned int> mIonBufLength;
};

class CameraAdapter: public FrameNotifier, public virtual RefBase
{
protected:
    enum AdapterActiveStates {
        INTIALIZED_ACTIVE =     1 << 0,
        LOADED_PREVIEW_ACTIVE = 1 << 1,
        PREVIEW_ACTIVE =        1 << 2,
        LOADED_CAPTURE_ACTIVE = 1 << 3,
        CAPTURE_ACTIVE =        1 << 4,
        BRACKETING_ACTIVE =     1 << 5,
        AF_ACTIVE =             1 << 6,
        ZOOM_ACTIVE =           1 << 7,
        VIDEO_ACTIVE =          1 << 8,
    };
public:
    typedef struct
        {
         void *mBuffers;
         uint32_t *mOffsets;
         int mFd;
         size_t mLength;
         size_t mCount;
         size_t mMaxQueueable;
        } BuffersDescriptor;

    enum CameraCommands
        {
        CAMERA_START_PREVIEW                        = 0,
        CAMERA_STOP_PREVIEW                         = 1,
        CAMERA_START_VIDEO                          = 2,
        CAMERA_STOP_VIDEO                           = 3,
        CAMERA_START_IMAGE_CAPTURE                  = 4,
        CAMERA_STOP_IMAGE_CAPTURE                   = 5,
	CAMERA_PERFORM_AUTOFOCUS                    = 6,
	CAMERA_CANCEL_AUTOFOCUS                     = 7,
	CAMERA_PREVIEW_FLUSH_BUFFERS                = 8,
	CAMERA_START_SMOOTH_ZOOM                    = 9,
	CAMERA_STOP_SMOOTH_ZOOM                     = 10,
        CAMERA_USE_BUFFERS_PREVIEW                  = 11,
        CAMERA_SET_TIMEOUT                          = 12,
        CAMERA_CANCEL_TIMEOUT                       = 13,
        CAMERA_START_BRACKET_CAPTURE                = 14,
        CAMERA_STOP_BRACKET_CAPTURE                 = 15,
        CAMERA_QUERY_RESOLUTION_PREVIEW             = 16,
        CAMERA_QUERY_BUFFER_SIZE_IMAGE_CAPTURE      = 17,
        CAMERA_QUERY_BUFFER_SIZE_PREVIEW_DATA       = 18,
        CAMERA_USE_BUFFERS_IMAGE_CAPTURE            = 19,
        CAMERA_USE_BUFFERS_PREVIEW_DATA             = 20,
        CAMERA_TIMEOUT_EXPIRED                      = 21,
        CAMERA_START_FD                             = 22,
        CAMERA_STOP_FD                              = 23,
        CAMERA_SWITCH_TO_EXECUTING                  = 24,
        };

    enum CameraMode
        {
        CAMERA_PREVIEW,
        CAMERA_IMAGE_CAPTURE,
        CAMERA_VIDEO,
        CAMERA_MEASUREMENT
        };

    enum AdapterState {
        INTIALIZED_STATE           = INTIALIZED_ACTIVE,
        LOADED_PREVIEW_STATE       = LOADED_PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        PREVIEW_STATE              = PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        LOADED_CAPTURE_STATE       = LOADED_CAPTURE_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        CAPTURE_STATE              = CAPTURE_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        BRACKETING_STATE           = BRACKETING_ACTIVE | CAPTURE_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE ,
        AF_STATE                   = AF_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        ZOOM_STATE                 = ZOOM_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        VIDEO_STATE                = VIDEO_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        VIDEO_AF_STATE             = VIDEO_ACTIVE | AF_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
        VIDEO_ZOOM_STATE           = VIDEO_ACTIVE | ZOOM_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
	VIDEO_LOADED_CAPTURE_STATE = VIDEO_ACTIVE | LOADED_CAPTURE_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
	VIDEO_CAPTURE_STATE        = VIDEO_ACTIVE | CAPTURE_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
	AF_ZOOM_STATE              = AF_ACTIVE | ZOOM_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
	BRACKETING_ZOOM_STATE      = BRACKETING_ACTIVE | ZOOM_ACTIVE | PREVIEW_ACTIVE | INTIALIZED_ACTIVE,
    };

public:

    virtual int initialize(CameraProperties::Properties*) = 0;

    virtual int setErrorHandler(ErrorNotifier *errorNotifier) = 0;

    virtual void enableMsgType(int32_t msgs,
                               frame_callback callback = NULL,
                               event_callback eventCb = NULL,
                               void *cookie = NULL) = 0;
    virtual void disableMsgType(int32_t msgs, void* cookie) = 0;
    virtual void returnFrame(void* frameBuf, CameraFrame::FrameType frameType) = 0;
    virtual void addFramePointers(void *frameBuf, void *buf) = 0;
    virtual void removeFramePointers() = 0;

    virtual int setParameters(const CameraParameters& params) = 0;
    virtual void getParameters(CameraParameters& params) = 0;

     status_t flushBuffers()
        {
        return sendCommand(CameraAdapter::CAMERA_PREVIEW_FLUSH_BUFFERS);
        }

    virtual int registerImageReleaseCallback(release_image_buffers_callback callback, void *user_data) = 0;

    virtual int registerEndCaptureCallback(end_image_capture_callback callback, void *user_data) = 0;

    virtual status_t sendCommand(CameraCommands operation, int value1=0, int value2=0, int value3=0) = 0;

    virtual ~CameraAdapter() {};

    virtual AdapterState getState() = 0;

    virtual AdapterState getNextState() = 0;

    virtual void onOrientationEvent(uint32_t orientation, uint32_t tilt) = 0;

    virtual status_t rollbackToInitializedState() = 0;

    virtual status_t getState(AdapterState &state) = 0;

    virtual status_t getNextState(AdapterState &state) = 0;

protected:

    virtual status_t setState(CameraCommands operation) = 0;
    virtual status_t commitState() = 0;
    virtual status_t rollbackState() = 0;
};

class DisplayAdapter : public BufferProvider, public virtual RefBase
{
public:
    typedef struct S3DParameters_t
    {
        int mode;
        int framePacking;
        int order;
        int subSampling;
    } S3DParameters;

    virtual int initialize() = 0;
    virtual int setPreviewWindow(struct preview_stream_ops *window) = 0;
    virtual int setFrameProvider(FrameNotifier *frameProvider) = 0;
    virtual int setErrorHandler(ErrorNotifier *errorNotifier) = 0;
    virtual int enableDisplay(int width, int height, struct timeval *refTime = NULL, S3DParameters *s3dParams = NULL) = 0;
    virtual int disableDisplay(bool cancel_buffer = true) = 0;
    virtual int pauseDisplay(bool pause) = 0;
#if PPM_INSTRUMENTATION || PPM_INSTRUMENTATION_ABS
    virtual int setSnapshotTimeRef(struct timeval *refTime = NULL) = 0;
#endif
    virtual int useBuffers(void *bufArr, int num) = 0;
    virtual bool supportsExternalBuffering() = 0;
    virtual int maxQueueableBuffers(unsigned int& queueable) = 0;
};

static void releaseImageBuffers(void *userData);
static void endImageCapture(void *userData);

class CameraHal

{

public:
    static const int NO_BUFFERS_PREVIEW;
    static const int NO_BUFFERS_IMAGE_CAPTURE;
    static const uint32_t VFR_SCALE = 1000;

public:
    void setCallbacks(camera_notify_callback notify_cb,
                        camera_data_callback data_cb,
                        camera_data_timestamp_callback data_cb_timestamp,
                        camera_request_memory get_memory,
                        void *user);

    void onOrientationEvent(uint32_t orientation, uint32_t tilt);

    void        enableMsgType(int32_t msgType);

    void        disableMsgType(int32_t msgType);

    int        msgTypeEnabled(int32_t msgType);

    int    startPreview();

    int setPreviewWindow(struct preview_stream_ops *window);

    void	stopPreview();

    bool	previewEnabled();

    int		startRecording();

    void	stopRecording();

    int		recordingEnabled();

    void        releaseRecordingFrame(const void *opaque);

    int		autoFocus();

    int		cancelAutoFocus();

    int    takePicture();

    int    cancelPicture();

    int    setParameters(const char* params);
    int    setParameters(const CameraParameters& params);

    char*  getParameters();
    void putParameters(char *);

    int sendCommand(int32_t cmd, int32_t arg1, int32_t arg2);

    void release();

    int dump(int fd) const;


		status_t storeMetaDataInBuffers(bool enable);

public:

    CameraHal(int cameraId);

    ~CameraHal();

    status_t initialize(CameraProperties::Properties*);

    void deinitialize();

#if PPM_INSTRUMENTATION || PPM_INSTRUMENTATION_ABS
    static void PPM(const char *);
    static void PPM(const char *, struct timeval*, ...);
#endif

    status_t freeImageBufs();

    status_t signalEndImageCapture();

    static void eventCallbackRelay(CameraHalEvent* event);
    void eventCallback(CameraHalEvent* event);
    void setEventProvider(int32_t eventMask, MessageNotifier * eventProvider);

private:

    bool        setVideoModeParameters(const CameraParameters&);

    bool       resetVideoModeParameters();

    status_t        restartPreview();

    status_t parseResolution(const char *resStr, int &width, int &height);

    void insertSupportedParams();

    status_t allocPreviewDataBufs(size_t size, size_t bufferCount);

    status_t freePreviewDataBufs();

    status_t allocPreviewBufs(int width, int height, const char* previewFormat, unsigned int bufferCount, unsigned int &max_queueable);

    status_t allocVideoBufs(uint32_t width, uint32_t height, uint32_t bufferCount);

    status_t allocImageBufs(unsigned int width, unsigned int height, size_t length, const char* previewFormat, unsigned int bufferCount);

    status_t freePreviewBufs();

    status_t freeVideoBufs(void *bufs);

    bool isResolutionValid(unsigned int width, unsigned int height, const char *supportedResolutions);

    bool isParameterValid(const char *param, const char *supportedParams);
    bool isParameterValid(int param, const char *supportedParams);
    status_t doesSetParameterNeedUpdate(const char *new_param, const char *old_params, bool &update);


    void initDefaultParameters();

    void dumpProperties(CameraProperties::Properties& cameraProps);

    status_t startImageBracketing();

    status_t stopImageBracketing();

    void setShutter(bool enable);

    void forceStopPreview();

    void selectFPSRange(int framerate, int *min_fps, int *max_fps);

    void setPreferredPreviewRes(int width, int height);
    void resetPreviewRes(CameraParameters *mParams, int width, int height);

public:
    int32_t mMsgEnabled;
    bool mRecordEnabled;
    nsecs_t mCurrentTime;
    bool mFalsePreview;
    bool mPreviewEnabled;
    uint32_t mTakePictureQueue;
    bool mBracketingEnabled;
    bool mBracketingRunning;
    bool mShutterEnabled;
    bool mMeasurementEnabled;
    static const char PARAMS_DELIMITER[];

    CameraAdapter *mCameraAdapter;
    sp<AppCallbackNotifier> mAppCallbackNotifier;
    sp<DisplayAdapter> mDisplayAdapter;
    sp<MemoryManager> mMemoryManager;

    sp<IMemoryHeap> mPictureHeap;

    int* mGrallocHandles;
    bool mFpsRangeChangedByApp;

#if PPM_INSTRUMENTATION || PPM_INSTRUMENTATION_ABS

    static struct timeval ppm_start;
    static struct timeval mStartFocus;
    static struct timeval mStartPreview;
    static struct timeval mStartCapture;

#endif

private:
    bool mDynamicPreviewSwitch;

    bool mDisplayPaused;

    int mCameraIndex;

    mutable Mutex mLock;

    sp<SensorListener> mSensorListener;

    void* mCameraAdapterHandle;

    CameraParameters mParameters;
    bool mPreviewRunning;
    bool mPreviewStateOld;
    bool mRecordingEnabled;
    EventProvider *mEventProvider;

    int32_t *mPreviewDataBufs;
    uint32_t *mPreviewDataOffsets;
    int mPreviewDataFd;
    int mPreviewDataLength;
    int32_t *mImageBufs;
    uint32_t *mImageOffsets;
    int mImageFd;
    int mImageLength;
    int32_t *mPreviewBufs;
    uint32_t *mPreviewOffsets;
    int mPreviewLength;
    int mPreviewFd;
    int32_t *mVideoBufs;
    uint32_t *mVideoOffsets;
    int mVideoFd;
    int mVideoLength;

    int mBracketRangePositive;
    int mBracketRangeNegative;

    BufferProvider *mBufProvider;
    BufferProvider *mVideoBufProvider;


    CameraProperties::Properties* mCameraProperties;

    bool mPreviewStartInProgress;

    bool mSetPreviewWindowCalled;

    uint32_t mPreviewWidth;
    uint32_t mPreviewHeight;
    int32_t mMaxZoomSupported;

    int mVideoWidth;
    int mVideoHeight;

};


}; // namespace android

#endif
