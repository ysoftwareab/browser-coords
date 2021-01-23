ifeq (,$(wildcard support-firecloud/Makefile))
INSTALL_SUPPORT_FIRECLOUD := $(shell git submodule update --init --recursive support-firecloud)
ifneq (,$(filter undefine,$(.FEATURES)))
undefine INSTALL_SUPPORT_FIRECLOUD
endif
endif

include support-firecloud/build.mk/generic.common.mk
include support-firecloud/build.mk/node.common.mk
include support-firecloud/build.mk/js.build.dts.mk
include support-firecloud/build.mk/js.check.eslint.mk
include support-firecloud/build.mk/js.check.tsc.mk
include support-firecloud/build.mk/core.misc.release.npg.mk

# ------------------------------------------------------------------------------

BROWSERIFY = $(call npm-which,BROWSERIFY,browserify)

SF_VENDOR_FILES_IGNORE += \
	-e "^docs/.\+\.browserify\.js$$" \

SF_DEPS_TARGETS += \
	.github/workflows/main.yml \

SF_BUILD_TARGETS += \
	docs/play.browserify.js \
	docs/demo.browserify.js \

# ------------------------------------------------------------------------------

.github/workflows/main.yml: .github/workflows/main.yml.tpl .github/workflows.src/main.yml support-firecloud/package.json
	$(call sf-generate-from-template)


docs/%.browserify.js: docs/%.js
	$(BROWSERIFY) $< -o $@
