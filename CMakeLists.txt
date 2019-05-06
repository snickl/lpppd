cmake_minimum_required(VERSION 3.1.0)
if(POLICY CMP0076)
    cmake_policy(SET CMP0076 NEW)
endif()
project(lpppd C)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_RULE_MESSAGES OFF)

set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "${CMAKE_EXE_LINKER_FLAGS_MINSIZEREL} -s")

option(OPTION_LPPPD_INET6 "Support for IPv6" ON)
option(OPTION_LPPPD_PPPD_FILTER "Support for PPP packet filtering" OFF)
option(OPTION_LPPPD_PPPD_MULTILINK "Enable multilink PPP" OFF)
option(OPTION_DEBUG "Enable verbose debugging" OFF)

include(CheckIncludeFiles)
include(CheckFunctionExists)
include(CheckLibraryExists)
check_include_files(crypt.h HAVE_CRYPT_H)
check_include_files(paths.h HAVE_PATHS_H)
check_include_files(shadow.h HAVE_SHADOW_H)
check_library_exists(shadow getspent "" HAVE_LIBSHADOW)
check_library_exists(util logwtmp "" HAVE_LOGWTMP)
check_function_exists(mmap HAVE_MMAP)
check_function_exists(pread HAVE_PREAD)
check_function_exists(pwrite HAVE_PWRITE)
check_include_files(security/pam_appl.h HAVE_PAMAPPL_H)
check_include_files("sys/types.h;pcap-bpf.h" HAVE_PCAPBPF_H)
check_include_files(openssl/crypto.h HAVE_CRYPTO_H)
check_include_files(systemd/sd-daemon.h HAVE_SD_DAEMON_H)
configure_file(${PROJECT_SOURCE_DIR}/include/config.h.in ${PROJECT_BINARY_DIR}/include/config.h)

if (HAVE_MMAP)
	add_definitions(-DHAVE_MMAP)
endif()

if (HAVE_PREAD)
	add_definitions(-DHAVE_PREAD)
endif()

if (HAVE_PWRITE)
	add_definitions(-DHAVE_PWRITE)
endif()

if (OPTION_LPPPD_INET6)
	add_definitions(-DINET6)
endif()

if (OPTION_DEBUG)
	add_definitions(-DDEBUGALL)
endif()

include_directories(include)

add_subdirectory("${PROJECT_SOURCE_DIR}/pppd")
add_subdirectory("${PROJECT_SOURCE_DIR}/chat")
add_subdirectory("${PROJECT_SOURCE_DIR}/pppstats")
add_subdirectory("${PROJECT_SOURCE_DIR}/pppdump")
