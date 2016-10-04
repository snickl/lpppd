# Change Log

## [1] - 2016-11-13

### Removed

- Support for non-Linux systems
- Novell IPX protocol
- MS-CHAP/MPPE protocols
- Support for libdes
- Legacy build system

### Added

- CMake build system
- All changes from https://github.com/paulusmack/ppp since ppp-2.4.7
- Several patches from the Fedora project
- Simon Arlott: Add client CHAP authentication timeout
- Tydus: Added an /etc/ppp/ipv6-pre-up script
- Stanislav Voroniy: Possibility to rename interface in pre-up script
  from vyatta-ppp
- Roger Shimizu: Add a sample ipv6-up script to add/replace default
  route for IPv6
- Jan Just Keijser: EAP-TLS patch, without MPPE support (inactive)

### Fixed

- George Burgess IV: Remove unused declaration of ttyname
- Dmitry Deshevoy: Count only relevant lines from syslog

### Security

- RobertoM1: Fix buffer overflow in radius plugin
