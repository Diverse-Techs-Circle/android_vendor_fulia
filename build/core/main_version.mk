# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# FuliaUI System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.fulia.build.version=$(LINEAGE_VERSION) \
    ro.fulia.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(FULIA_VERSION) \
    ro.fulialegal.url=https://lineageos.org/legal

# FuliaUI Platform Display Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.fulia.display.version=$(LINEAGE_DISPLAY_VERSION)

# LineageOS Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
