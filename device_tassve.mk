# Copyright (C) 2010 The Android Open Source Project
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

## SAMSUNG_BOOTLOADER is the product model changed into appropriate string parsed by init.
## Example: -GT-I5500 becomes gt-i5500board, -GT-S5830 becomes gt-s5830board, and so on.
SAMSUNG_BOOTLOADER := $(shell echo $(PRODUCT_VERSION_DEVICE_SPECIFIC)board | tr '[A-Z]' '[a-z]' | cut -c 2-)

# Ramdisk
PRODUCT_PACKAGES += \
    pre_init \
    pre_adbd \
    recovery.fstab \
    init.$(SAMSUNG_BOOTLOADER).rc \
    init.$(SAMSUNG_BOOTLOADER).bt.rc \
    init.$(SAMSUNG_BOOTLOADER).fs.rc \
    init.$(SAMSUNG_BOOTLOADER).gps.rc \
    init.$(SAMSUNG_BOOTLOADER).sensors.rc \
    init.$(SAMSUNG_BOOTLOADER).usb.rc \
    init.$(SAMSUNG_BOOTLOADER).wifi.rc \
    init.recovery.$(SAMSUNG_BOOTLOADER).rc \
    ueventd.$(SAMSUNG_BOOTLOADER).rc

# Inherit products
$(call inherit-product, device/samsung/bcm21553-common/common.mk)
$(call inherit-product, vendor/samsung/tassve/vendor.mk)

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/tassve/overlay

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml

# Enable repeatable keys in CWM
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cwm.enable_key_repeat=true \
    ro.cwm.repeatable_keys=114,115

# Add MDPI assets, in addition to LDPI
PRODUCT_LOCALES += ldpi mdpi
