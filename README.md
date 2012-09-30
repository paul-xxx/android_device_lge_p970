Black Jelly Bean Project
========================
Here LG Optimus Black device folder for build Android 4.1.x

1. Download CM10 source codes
------------------------------------------
- All info you can find in wiki or from other source

2. Download my source codes:
--------------------------------
- cd your_android_source_codes_dir
- git clone git://github.com/paul-xxx/android_device_lge_p970.git -b jellybean device/lge/p970
- git clone git://github.com/paul-xxx/android_device_lge_p970.git -b jellybean vendor/lge/p970
- git clone git://github.com/paul-xxx/android_kernel_lge_sniper.git -b 3.0 kernel/lge/sniper
- And other components from this git repo

3. Build ROM:
-------------
- cd your_android_source_codes_dir
- source build/envsetup.sh && brunch cm_p970-userdebug

4. Installing:
--------------
- Grab new file named cm-10-(DATE)-UNOFFICIAL-p970 from your_android_source_codes_dir/out/target/product/p970
- Push ZIP to SD Card and install
- Install Google Apps
