#!/bin/bash

# 1. Voraussetzungen installieren
sudo apt update
sudo apt install -y openjdk-21-jdk wget unzip curl

# 2. Variablen
INSTALL_DIR="/opt"
JDK_PATH="/usr/lib/jvm/java-21-openjdk-amd64"

# 3. Download-Link holen (Robustere API-Abfrage)
echo "Suche nach der neuesten Ghidra Version..."
GHIDRA_URL=$(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest \
    | grep "browser_download_url" \
    | grep -E "_[0-9.]+_PUBLIC_[0-9]+\.zip" \
    | cut -d '"' -f 4 | head -n 1)

if [ -z "$GHIDRA_URL" ]; then
    GHIDRA_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_12.0.3_build/ghidra_12.0.3_PUBLIC_20260210.zip"
fi

# 4. Download & Unzip
echo "Lade Ghidra herunter: $GHIDRA_URL"
wget -q --show-progress -O /tmp/ghidra.zip "$GHIDRA_URL"

echo "Entpacke nach $INSTALL_DIR..."
sudo unzip -q -o /tmp/ghidra.zip -d $INSTALL_DIR
rm /tmp/ghidra.zip

# 5. Pfad finden
GHIDRA_FOLDER=$(find $INSTALL_DIR -maxdepth 1 -type d -name "ghidra_*" | head -n 1)

# 6. Symlink & Alias (Sudo für System-Links)
sudo ln -sf "$GHIDRA_FOLDER/ghidraRun" /usr/local/bin/ghidra

if ! grep -q "alias ghidra=" ~/.bashrc; then
    echo "alias ghidra='$GHIDRA_FOLDER/ghidraRun'" >> ~/.bashrc
fi

# 7. JDK Pfad fixen
echo "Konfiguriere JDK-Pfad..."
if [ -f "$GHIDRA_FOLDER/support/launch.properties" ]; then
    # Entfernt alte Einträge und setzt den korrekten Pfad
    sudo sed -i '/VMARGS_JDK=/d' "$GHIDRA_FOLDER/support/launch.properties"
    echo "VMARGS_JDK=$JDK_PATH" | sudo tee -a "$GHIDRA_FOLDER/support/launch.properties" > /dev/null
fi

echo "-------------------------------------------------------"
echo "Ghidra wurde erfolgreich installiert!"
echo "Verzeichnis: $GHIDRA_FOLDER"
echo "Befehl: ghidra (nach 'source ~/.bashrc')"
echo "-------------------------------------------------------"
