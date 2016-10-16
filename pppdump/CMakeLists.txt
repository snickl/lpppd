include_directories(${PROJECT_SOURCE_DIR}/include/net)

add_executable(pppdump pppdump.c bsd-comp.c deflate.c zlib.c)

install(TARGETS pppdump DESTINATION sbin)
install(FILES pppdump.8 DESTINATION share/man/man8)
