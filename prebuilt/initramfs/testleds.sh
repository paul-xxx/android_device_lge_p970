#!/system/bin/sh
echo '255' > sys/devices/platform/i2c_omap.2/i2c-2/2-001a/led_brightness
echo '1' > sys/devices/platform/i2c_omap.2/i2c-2/2-001a/led_onoff
echo '1' > sys/devices/platform/i2c_omap.2/i2c-2/2-001a/blink_enable
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x06
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x07
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0D
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0E
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x11
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x03
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x04
sleep 0.10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x03
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x04
sleep 0.10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x11
sleep 0.10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0D
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0E
sleep 0.10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x06
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x07
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x03
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x04
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x11
sleep 0.10
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0D
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x0E
sleep 0.10
echo '255' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x06
echo '0' > /sys/devices/platform/i2c_omap.2/i2c-2/2-001a/0x07
echo '1' > sys/devices/platform/i2c_omap.2/i2c-2/2-001a/led_sync

