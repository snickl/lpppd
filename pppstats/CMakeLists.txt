add_executable(pppstats pppstats.c)

install(TARGETS pppstats DESTINATION sbin)
install(FILES pppstats.8 DESTINATION share/man/man8)
