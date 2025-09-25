# FiveM Mechanic Magnet Script
## nblbnk_cargobob-magnetic

### 🛠️ Overview

This script is designed for **FiveM servers** and adds functionality for **mechanics** to use a **magnet** with cargo helicopters.  
It allows toggling the magnet, attaching/detaching vehicles, and integrates cleanly with **QBCore**.  
Originally built for **ESX**, now fully reworked and optimized for **QBCore**.

---

### ✨ Features

- 🚁 Activate/Deactivate magnet (Cargobob hook system)
- 🧲 Attach & detach nearby vehicles (toggle)
- 👨‍🔧 Job-lock: Only players with the `mechanic` job can use it
- 🔄 Clean native detachment & reset
- 🔧 Fully converted for **QBCore framework**
- 🔒 Controlled via `H` and `E` keys only
- 🧠 Optimized notifications via `QBCore.Functions.Notify`

> ⚠️ **Important:**  
> Once the magnet is deactivated, the hook must be reset via `/removehook` or respawning the Cargobob.

---

### 📦 Installation

1. Download or clone this repository
2. Place the folder inside your `resources/` directory
3. Add the resource to your `server.cfg`:
   ```
   ensure nblbnk_cargobob-magnetic
   ```
4. Restart your server or run:
   ```
   refresh
   start nblbnk_cargobob-magnetic
   ```

---

### 🎮 Controls

| Key                | Action                          |
|--------------------|----------------------------------|
| `H`                | Deploy / Retract Magnet Hook     |
| `E`                | Attach / Detach vehicle          |
| `/removehook`      | Manual detach/reset (chat cmd)   |

> 🧑‍🔧 **Mechanic job required to use all features!**

---

### 🤝 Contributing

Pull requests and issue reports are always welcome!  
Help improve this project and suggest new features to keep roleplay evolving.

---

### 📜 License & Usage Rules

- ✅ Free to use in all FiveM projects
- ❌ **Do NOT sell** this script or claim as your own
- ✅ Credits to the original author must remain intact
- 🧩 Open-source for community improvements

---

### 🧑‍💻 Author's Statement

> I developed this script to add realism and immersion for mechanic RP in FiveM.  
> Please respect the community spirit — don’t monetize this work, but feel free to share and enhance it.  
> Thank you to everyone supporting **open development**.

---

### 📌 Community

**JOIN DISCORD ➞** [https://discord.gg/scg3YqZFU6](https://discord.gg/scg3YqZFU6)  
Let’s grow this together — feedback, bugs, and ideas are welcome!

---

🔻🔻🔻  
🦉 **NEBELBANK.NET**  
🌐 [https://linktr.ee/nebelbanknet](https://linktr.ee/nebelbanknet)  
💬 THE POWER OF PERFECTION  
🔥 DON’T FLAME WITHOUT BRAIN!  
🏆 YOUR SATISFACTION IS OUR ACHIEVEMENT!  
🔺🔺🔺
