# CMake project wrapper Makefile

ifeq ($(CMAKE),)
	CMAKE := cmake
endif

RMDIR := $(CMAKE) -E remove_directory
MKDIR := $(CMAKE) -E make_directory
CPDIR := $(CMAKE) -E copy_directory
CP    := $(CMAKE) -E copy
LN    := $(CMAKE) -E create_symlink
RMF   := $(CMAKE) -E remove -f

# Don't change here; override in local.mk instead!

TOOLCHAIN_FILE   :=
BUILD_TYPE       := "MinSizeRel"
OPTIONS          :=

-include local.mk

all: ./build/Makefile
	@$(CMAKE) --build build

./build/Makefile: local.mk Makefile
	@- $(RMDIR) ./build
	@($(MKDIR) build > /dev/null)
	@(cd build > /dev/null 2>&1 && \
		$(CMAKE) -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
		      -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		      ${OPTIONS} \
		      ..)

.PHONY: install
install:
	@$(CMAKE) --build build --target $@

.PHONY: clean
clean:
	@- $(RMDIR) ./build
