# Zabbix Agent 2 8.0 – automatická registrace

**Autor:** Dennis Jiřička  
**Škola:** SPOŠ Dvůr Králové nad Labem  
**Obor:** Informační technologie  
**Operační systém:** Debian 13 (Trixie)

## 1. Popis projektu

Tento projekt slouží k automatickému vytvoření virtuálního serveru s operačním systémem Debian 13 pomocí nástroje Vagrant a VirtualBox.

Součástí automatického provisioningu je instalace a konfigurace Zabbix Agent 2 ve verzi 8.0 LTS z oficiálního repozitáře Zabbix.

Agent je nakonfigurován pro komunikaci se školním Zabbix serverem `enceladus.pfsense.cz` a automatickou registraci pomocí metadat `SPOS`.

## 2. Použité technologie

- **Vagrant** – automatizace vytvoření a konfigurace virtuálního stroje.
- **VirtualBox** – virtualizace operačního systému.
- **Debian 13 (Trixie)** – operační systém virtuálního serveru.
- **Zabbix Agent 2 8.0 LTS** – monitoring virtuálního serveru.
- **Bash** – instalační a konfigurační skripty.

## 3. Struktura projektu

| Soubor / složka | Popis |
|---|---|
| `Vagrantfile` | Definice virtuálního stroje a automatického provisioningu. |
| `install-zabbix-agent2.sh` | Instalace oficiálního Zabbix repozitáře a Zabbix Agent 2. |
| `configure-zabbix-agent2.sh` | Konfigurace Zabbix agenta a spuštění služby. |
| `Images/` | Screenshoty dokumentující průběh a výsledek projektu. |
| `Example/` | Původní ukázkové soubory. |
| `Vagrant/` | Další ukázkové konfigurace Vagrantu. |

## 4. Konfigurace Zabbix agenta

Agent používá následující parametry:

| Parametr | Hodnota |
|---|---|
| `Server` | `enceladus.pfsense.cz` |
| `ServerActive` | `enceladus.pfsense.cz` |
| `Hostname` | Automaticky vytvořený unikátní hostname |
| `HostMetadata` | `SPOS` |

Hostname je vytvořen z označení projektu a části systémového ID virtuálního stroje. Díky tomu zůstává stabilní i při opakovaném spuštění provisioningu.

## 5. Spuštění projektu

### Požadavky

- Nainstalovaný Vagrant.
- Nainstalovaný Oracle VirtualBox.
- Git (volitelné, pokud je projekt již stažený).

### Vytvoření virtuálního stroje

V kořenové složce projektu spusť:

```bash
vagrant up
```

Vagrant vytvoří virtuální stroj s Debianem 13 a automaticky provede instalaci i konfiguraci Zabbix Agent 2.

### Připojení k virtuálnímu stroji

```bash
vagrant ssh
```

### Opakování provisioningu

```bash
vagrant provision
```

### Vypnutí virtuálního stroje

```bash
vagrant halt
```

## 6. Ověření funkčnosti

Stav služby lze ověřit příkazem:

```bash
sudo systemctl status zabbix-agent2
```

Verzi agenta lze zobrazit příkazem:

```bash
sudo /usr/sbin/zabbix_agent2 -V
```

Kontrola lokální funkčnosti agenta:

```bash
sudo /usr/sbin/zabbix_agent2 -t agent.ping
```

Kontrola nastavení:

```bash
sudo grep -E '^(Hostname|Server|ServerActive|HostMetadata)=' /etc/zabbix/zabbix_agent2.conf
```

Očekávaný výsledek lokálního testu:

```text
agent.ping [s|1]
```

## 7. Zabbix server

Zabbix Agent 2 je nakonfigurován pro komunikaci se školním serverem:

`enceladus.pfsense.cz`

Cílem je automatická registrace virtuálního serveru prostřednictvím nastavených metadat `SPOS` a následné monitorování jeho stavu a systémových údajů.

## 8. Screenshoty

Ve složce `Images/` jsou uloženy screenshoty dokumentující instalaci, konfiguraci a ověření funkčnosti projektu.

## 9. Závěr

Projekt automatizuje vytvoření Debian 13 serveru a instalaci i konfiguraci Zabbix Agent 2 ve verzi 8.0 LTS.

Po spuštění příkazu `vagrant up` proběhne celý proces automaticky bez nutnosti ruční instalace a konfigurace agenta.
