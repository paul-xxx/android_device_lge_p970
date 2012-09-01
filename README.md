Black ICS Project
=================
LG Optimus Black device folder for build Android 4.0.x

Download:
---------
- mkdir blackics
- cd blackics
- repo init -u git://github.com/paul-xxx/android.git -b ics
- repo sync -j4

Update source:
--------------
- cd blackics
- repo sync -j4

Build:
------
- rm -rf out/target
- source build/envsetup.sh && brunch cm_p970-userdebug

Installing:
-----------
- Grab new file named cm-9-(DATE)-UNOFFICIAL-p970 from source_codes_dir/out/target/product/p970
- Push to SD Card and install
- Install Google Apps
