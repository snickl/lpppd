add_definitions(-DTERMIOS -DSIGTYPE=void -UNO_SLEEP -DFNDELAY=O_NDELAY)
add_executable(chat chat.c)

install(TARGETS chat DESTINATION sbin)
install(FILES chat.8 DESTINATION share/man/man8)
