# 💀 nosleep-cracker

**nosleep-cracker** je automatizovaný nástroj pro zachytávání WPA3 (SAE) handshake a jejich crackování pomocí `hcxdumptool`, `hcxpcapngtool` a `hashcat`.  
Nástroj běží v Bash a je určen pro etické hackery, bezpečnostní testery a síťové laby.

> ⚠️ Tento nástroj je určen **výhradně pro vzdělávací účely**. Používejte pouze na sítích, ke kterým máte oprávnění.

---

## ⚙️ Funkce

- Přepnutí Wi-Fi adaptéru do monitor módu
- Zachycení WPA3 SAE handshake (i PMKID, pokud je dostupný)
- Automatický převod `.pcapng` do formátu `.22000` (kompatibilní s hashcat)
- Crack hesla pomocí slovníkového útoku (rockyou.txt)
- Barevné a přehledné rozhraní v terminálu

---

## 🛠️ Požadavky

- Linux (doporučeno Kali Linux nebo Parrot OS)
- Bash
- Wi-Fi adaptér s podporou monitor módu a packet injection (např. Alfa AWUS036ACH)
- Nainstalované nástroje:

```bash
sudo apt install hcxdumptool hashcat hcxpcapngtool aircrack-ng -y
