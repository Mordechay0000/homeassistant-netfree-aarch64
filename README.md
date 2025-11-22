**Home Assistant – NetFree Compatible (Aarch64 Build)**
Customized Aarch64 build of Home Assistant with full NetFree compatibility.
This repository includes all required adjustments to ensure outbound HTTPS traffic, certificate validation, and Python SSL modules operate correctly under the NetFree filtering environment.

Key features:

* Integrated NetFree root certificate.
* OpenSSL 3.0.2 compiled with settings compatible with NetFree’s CA (no X509 strict enforcement).
* Patched Python `_ssl` module compiled against the adjusted OpenSSL.
* Works in environments with musl-based or container-based deployments.
* Includes reproducible build steps and scripts for maintaining the patched environment.

Ideal for users running Home Assistant behind NetFree who need stable HTTPS, add-on connectivity, and integration support.

