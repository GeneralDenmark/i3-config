#!/bin/bash

# Based on the directions here: https://wiki.archlinux.org/index.php/DeveloperWiki:Building_in_a_Clean_Chroot
# This will take a while to build, with most of the time spent on QT4. There is some redundancy with creating
# multiple clean chroots, but I think this approach is easier and more reliable for most systems.

# Specify a build directory. Defaults to /tmp:
BUILDDIR="/tmp"

# Install devtools if it's not already installed:
if [ -n "$(pacman -Qi devtools)" ]
 then echo "devtools installed. Continuing"
 else echo "devtools not installed. Installing..."; sudo pacman -S devtools
fi

# Install git if it's not already installed:
if [ -n "$(pacman -Qi git)" ]
 then echo "git installed. Continuing"
 else echo "git not installed. Installing..."; sudo pacman -S git
fi

# Build the packages in /tmp by default:
echo "Moving to $BUILDDIR"
cd $BUILDDIR

# Build lib32-libmng:
echo "Building lib32-libmng (dependency)..."
if [ ! -d "lib32-libmng" ]; then
  # No lib32-libmng directory, so we clone the repo
  git clone https://aur.archlinux.org/lib32-libmng.git
  cd lib32-libmng
else
  # lib32-libmng dir exists, so cd and make sure the repo is up to date
  cd lib32-libmng
  git pull
fi
# Build the package in a clean chroot, then record the full package name:
multilib-build -c
LIBMNG_PKGNAME=$(ls -lAh | egrep 'pkg\.tar\.xz$' | sed -r 's/.*(lib32-.*)/\1/')
cd $BUILDDIR

# Build lib32-openssl-1.0:
echo "Building lib32-openssl-1.0 (dependency)..."
if [ ! -d "lib32-openssl-1.0" ]; then
  # No lib32-openssl-1.0 directory, so we clone the repo
  git clone https://aur.archlinux.org/lib32-openssl-1.0.git
  cd lib32-openssl-1.0
else
  # lib32-openssl-1.0 dir exists, so cd and make sure the repo is up to date
  cd lib32-openssl-1.0
  git pull
fi
# Build the package in a clean chroot, then record the full package name:
multilib-build -c
OPENSSL_PKGNAME=$(ls -lAh | egrep 'pkg\.tar\.xz$' | sed -r 's/.*(lib32-.*)/\1/')
cd $BUILDDIR

# Finally, build lib32-qt4:
echo "Building lib32-qt4 (main package)..."
if [ ! -d "lib32-qt4" ]; then
  git clone https://aur.archlinux.org/lib32-qt4.git
  cd lib32-qt4
else
  cd lib32-qt4
  git pull
fi
# Build in a clean chroot, but use the clean packages we just built.
# This line is recommended by the maintainer of the lib32-qt4 package:
multilib-build -c -- -I $BUILDDIR/lib32-libmng/$LIBMNG_PKGNAME -I $BUILDDIR/lib32-openssl-1.0/$OPENSSL_PKGNAME
QT4_PKGNAME=$(ls -lAh | egrep 'pkg\.tar\.xz$' | sed -r 's/.*(lib32-.*)/\1/')

# Install it:
echo "Installing lib32-qt4"
sudo pacman -U $QT4_PKGNAME

echo "Successfully installed $QT4_PKGNAME."