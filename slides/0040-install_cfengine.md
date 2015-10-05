# Install CFEngine

.fx: titleslide

---
## Installing CFEngine Community
Community (Core):

[Github](https://github.com/cfengine/core)
| [Tarballs](https://cfengine.com/product/community/source-code/)
| [Binary Packages](https://cfengine.com/product/community/)
| [Linux Package Repositories](https://cfengine.com/product/community/cfengine-linux-distros/)

    !console
    $ wget -O- http://cfengine.package-repos.s3.amazonaws.com/\
    quickinstall/quick-install-cfengine-community.sh | sudo bash

---
## Installing CFEngine Enterprise
Enterprise (Free for 25 hosts):

[Vagrant Environment](https://docs.cfengine.com/latest/guide-installation-and-configuration-general-installation-installation-enterprise-vagrant.html)
| [Binary Packages](http://cfengine.com/product/cfengine-enterprise-free-25/)

    !console
    $ wget http://cfengine.package-repos.s3.amazonaws.com/quickinstall/\
    quick-install-cfengine-enterprise.sh
    sudo bash ./quick-install-cfengine-enterprise.sh hub

---
## Enterprise Features
* Inventory Reporting
* Change Reporting
* Audit and Compliance
* Anomoly Detection
* Monitoring
* REST API
* SQL Reporting
* File Integrity Monitoring

## presenter notes
Design Center is in beta. Does not have significant adoption yet, still
evaluating workflows and toolchain integration.

If you're interested in working on Design Center or giving feedback please
contact me or Ted Zlatanov, the Design Center toolchain maintainer.

