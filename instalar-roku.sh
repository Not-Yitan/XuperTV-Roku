#!/usr/bin/env bash
# Empaqueta e instala el canal en un Roku con modo desarrollador activado.
# Uso: ./instalar-roku.sh IP_DEL_ROKU CLAVE_DEVELOPER
set -euo pipefail
IP="${1:?Uso: $0 IP_DEL_ROKU CLAVE_DEVELOPER}"; PASS="${2:?Falta la clave del modo desarrollador}"
AQUI="$(cd "$(dirname "$0")" && pwd)"
ZIP="$(mktemp -d)/xupertv-roku.zip"
(cd "$AQUI" && zip -qr "$ZIP" manifest source components images)
echo ">> Instalando en el Roku $IP..."
curl -s --digest -u "rokudev:$PASS" -F "mysubmit=Install" -F "archive=@$ZIP" "http://$IP/plugin_install" \
  | grep -o -i -E "Install Success|Identical to previous version|Install Failure[^<]*|Failed[^<]*" | head -3
