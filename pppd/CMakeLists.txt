add_executable(pppd auth.c ccp.c chap-md5.c chap-new.c demand.c eap.c ecp.c
		    fsm.c ipcp.c lcp.c magic.c main.c options.c session.c
                    sys-linux.c tty.c upap.c utils.c)

add_definitions(-DMAXOCTETS)

find_library(LIBRT rt)
if(LIBRT)
	target_link_libraries(pppd ${LIBRT})
endif()

if (NOT HAVE_CRYPT_H)
	message(FATAL_ERROR "Need crypt()")
else()
	target_link_libraries(pppd -lcrypt)
endif()

if (HAVE_PATHS_H)
	add_definitions(-DHAVE_PATHS_H)
endif()

if (HAVE_SHADOW_H)
	add_definitions(-DHAS_SHADOW)
	if(HAVE_LIBSHADOW) # may be part of libc
		target_link_libraries(pppd -lshadow)
	endif()
endif()

if (HAVE_LOGWTMP)
	add_definitions(-DHAVE_LOGWTMP)
	target_link_libraries(pppd -lutil)
endif()

if (HAVE_PAMAPPL_H)
	add_definitions(-DUSE_PAM)
	target_link_libraries(pppd -lpam)
endif()

if (HAVE_SD_DAEMON_H)
	add_definitions(-DSYSTEMD)
	target_link_libraries(pppd -lsystemd)
endif()

if (OPTION_LPPPD_INET6)
	target_sources(pppd PUBLIC ipv6cp.c eui64.c)
endif()

if (OPTION_LPPPD_PPPD_FILTER)
	if (NOT HAVE_PCAPBPF_H)
		message(FATAL_ERROR "Need pcap-bpf.h")
	endif()
	add_definitions(-DPPP_FILTER)
	target_link_libraries(pppd -lpcap)
endif()

if (OPTION_LPPPD_PPPD_MULTILINK)
	add_definitions(-DHAVE_MULTILINK -DUSE_TDB)
	target_sources(pppd PUBLIC multilink.c tdb.c spinlock.c)
endif()

if (OPTION_LPPPD_PPPD_EAPTLS AND HAVE_LIBCRYPTO)
	add_definitions(-DUSE_EAPTLS)
	target_sources(pppd PUBLIC eap-tls.c)
	target_link_libraries(pppd -lssl -lcrypto)
else()
	target_sources(pppd PUBLIC md5.c)
endif()

if (OPTION_LPPPD_PPPD_SRP)
	add_definitions(-DUSE_SRP)
	target_sources(pppd PUBLIC pppcrypt.c)
	add_executable(srp-entry srp-entry.c)
endif()

install(TARGETS pppd DESTINATION sbin)
install(FILES pppd.8 DESTINATION share/man/man8)
