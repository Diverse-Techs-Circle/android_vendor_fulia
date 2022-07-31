# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
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

FULIA_MOD_VERSION = v1.1
FULIA_BUILD_TYPE := UNOFFICIAL
FULIA_BUILD_ZIP_TYPE := VANILLA

ifeq ($(FULIA_GAPPS), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    ARROW_BUILD_ZIP_TYPE := GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(FULIA_OFFICIAL), true)
   LIST = $(shell cat infrastructure/devices/fulia.devices | awk '$$1 != "#" { print $$2 }')
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      FULIA_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
       FULIA_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

FULIA_VERSION := FuliaUI-$(FULIA_MOD_VERSION)-$(CURRENT_DEVICE)-$(FULIA_BUILD_TYPE)-$(shell date -u +%Y%m%d)-$(FULIA_BUILD_ZIP_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.fulia.version=$(FULIA_VERSION) \
  ro.fulia.releasetype=$(FULIA_BUILD_TYPE) \
  ro.fulia.ziptype=$(FULIA_BUILD_ZIP_TYPE) \
  ro.modversion=$(FULIA_MOD_VERSION)

FULIA_DISPLAY_VERSION := FuliaUI-$(FULIA_MOD_VERSION)-$(FULIA_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.fulia.display.version=$(FULIA_DISPLAY_VERSION)
