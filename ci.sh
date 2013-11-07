#!/bin/sh

set -eu
set -x

sudo apt-get update
sudo apt-get install -y --force-yes aptirepo-upload make devscripts equivs git-core


# Dog food itself
make
sudo make install


puavo-build-debian-dir
sudo puavo-install-deps debian/control
puavo-dch $(cat VERSION)
puavo-debuild

aptirepo-upload -r $APTIREPO_REMOTE -b "git-$(echo "$GIT_BRANCH" | cut -d / -f 2)" ../puavo-devscripts*.changes
