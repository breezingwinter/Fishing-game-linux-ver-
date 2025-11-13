# 🎣 Fishing Game

A feature-rich terminal-based fishing game with RPG elements, written in Python.

![Python Version](https://img.shields.io/badge/python-3.7+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 🌟 Features

- **7 Unique Locations** - Lake, River, Ocean, Deep Sea, Volcanic Lake, Arctic, and Space!
- **100+ Fish Species** - From common Trout to mythical creatures like the Kraken
- **Mutation System** - Catch rare albino, glowing, golden, and shadow variants
- **Dynamic Weather** - Affects catch rates and fish availability
- **Day/Night Cycle** - Different fish appear at different times
- **RPG Progression** - Level up, earn XP, unlock new locations
- **Skill Tree** - Customize your fishing style
- **Equipment Shop** - Upgrade rods and bait
- **Achievement System** - Unlock rewards for milestones
- **Encyclopedia** - Track all discovered species
- **Trophy Room** - Display your most memorable catches
- **Mini-games** - Test your reflexes and memory
- **Save System** - Continue your fishing journey anytime

## 📋 Requirements

- Python 3.7 or higher
- colorama library

## 🚀 Quick Start

### Option 1: Automatic Installation (Recommended)

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File install_fishing_game.ps1
```

The installer will automatically:
- Check if Python is installed (and download it if needed)
- Download the game from GitHub
- Install required dependencies
- Create a launcher on your desktop
- Set up an update script

### Option 2: Manual Installation

1. **Install Python** (if not already installed)
   - Download from [python.org](https://www.python.org/downloads/)
   - Make sure to check "Add Python to PATH"

2. **Install colorama**
   ```bash
   pip install colorama
   ```

3. **Download the game**
   ```bash
   # Download fishgame.py from the repository
   curl -O https://raw.githubusercontent.com/Nokoiscool/Fishing-game/main/fishgame.py
   ```

4. **Run the Game**
   ```bash
   python fishgame.py
   ```

## 🎮 How to Play

### Starting Out
1. **Create your character** - Choose your name, distribute stats, and select difficulty
2. **Choose a location** - Start at the Lake (more locations unlock as you level up)
3. **Go fishing!** - Complete mini-games to catch fish
4. **Sell your catch** - Earn money to upgrade equipment
5. **Level up** - Gain skill points and unlock new content

### Controls
- Navigate menus using number keys
- Complete mini-games with keyboard input
- Type `99` in dev mode for debug menu (if enabled)

### Tips for Success
- 🎣 **Upgrade your rod** - Better catch rates mean fewer fish escape
- 🪱 **Use better bait** - Increases chances of rare fish
- 🌧️ **Fish in storms** - Rare and legendary fish are more common
- 🌙 **Try night fishing** - Different species appear at night
- 💪 **Allocate stats wisely**:
  - Strength → Better catch rate
  - Luck → More rare fish
  - Patience → Easier mini-games
- 💰 **Save mutations** - Golden and shadow fish sell for much more!

## 🟦 Fish Rarities

| Rarity | Description | Examples |
|--------|-------------|----------|
| Common | Easy to catch, low value | Trout, Cod, Perch |
| Uncommon | Moderate challenge | Bass, Tuna, Pike |
| Rare | Challenging to find | Sturgeon, Shark, Muskie |
| Legendary | Extremely rare | Arapaima, Coelacanth, Giant Grouper |
| Mythical | Nearly impossible | Kraken, Leviathan, Dragon |

## 🏆 Achievements

Unlock achievements by:
- Catching your first fish of each rarity
- Reaching catch milestones (50, 200+ fish)
- Earning $1,000,000
- Completing the encyclopedia
- Finding all mutation types

## 🛠️ Advanced Features

### Skill Tree
- **Rare Finder** - Increase rare fish spawn rate
- **Quick Reflexes** - Easier mini-games
- **Master Angler** - Better catch rate
- **Lucky Fisherman** - More mutations
- **Bargain Hunter** - Higher sell prices
- **Iron Grip** - Increased XP gain

### Equipment System
- **Rods** - From Bamboo to Godly (10 tiers)
- **Bait** - 6 types with increasing rarity boosts
- **Rod Durability** - Repair at the shop
- **Esky Upgrades** - Carry more fish

## 💾 Save Files

Save files are stored in:
- **Windows:** `C:\Users\[YourName]\Documents\FiskeSpill\game_save.json`
- **Linux/Mac:** `~/Documents/FiskeSpill/game_save.json`

## 🔄 Updating the Game

If you used the automatic installer, simply run:
- **Windows:** Double-click `Update Game.bat` in your Fishing-Game folder

Or manually download the latest version:
```bash
curl -O https://raw.githubusercontent.com/Nokoiscool/Fishing-game/main/fishgame.py
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Add new fish species
- Improve mini-games
- Submit pull requests

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🎨 Credits

Created with ❤️ using Python and colorama

---

## 📸 Screenshots

```
╔════════════════════════════════════╗
║    🎣 FISHING GAME 🎣                ║
╚════════════════════════════════════╝
Level: 5 | XP: 150/500 | 💰: $2,450
Weather: Stormy
Difficulty: Normal
Rod: Carbon Rod | Bait: Squid
```

## 🐛 Known Issues

- None currently reported

## 🗺️ Roadmap

- [ ] Multiplayer/Leaderboards
- [ ] More locations
- [ ] Fishing tournaments
- [ ] Crafting system
- [ ] Pet companions

---

**Happy Fishing! 🎣**
