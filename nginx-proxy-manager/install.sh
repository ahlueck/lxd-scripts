#!/usr/bin/env sh
TMP=/tmp/npm_install.sh
URL=https://raw.githubusercontent.com/ahlueck/lxd-scripts/main/nginx-proxy-manager/

if [ "$(uname)" != "Linux" ]; then
  echo "OS NOT SUPPORTED"
  exit 1
fi

DISTRO=$(cat /etc/*-release | grep -w ID | cut -d= -f2 | tr -d '"')
if [ "$DISTRO" != "alpine" ] && [ "$DISTRO" != "ubuntu" ] && [ "$DISTRO" != "debian" ]; then
  echo "DISTRO NOT SUPPORTED"
  exit 1
fi

INSTALL_SCRIPT=$DISTRO
if [ "$DISTRO" = "ubuntu" ]; then
  INSTALL_SCRIPT="debian"
fi

rm -rf $TMP
wget -O "$TMP" "$URL/$INSTALL_SCRIPT.sh"

chmod +x "$TMP"

if [ "$(command -v bash)" ]; then
  echo "bash"
  $(command -v sudo) bash "$TMP"
else
  echo "sh"
  sh "$TMP"
fi
