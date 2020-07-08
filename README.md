# Tibia NoDie
*NoDie* features macros, shortcuts and auto-healers for the PC game Tibia. Created with AutoHotkey, an automation scripting language for Windows.

These ahk scripts were developed for my personal use. I've used and improved them for over a year and never had issues with bans or BattleEye.

I am not playing Tibia anymore but, as I did put a lot of effort into understanding AHK and developing this, I'm sharing it for public use and maybe to colaborate with other AHK developers to improve it.

##### License

Feel free to edit and share it yourself, but give credit where credit is due.

## Installation
Install AutoHotkey, from [https://www.autohotkey.com/](https://www.autohotkey.com/).

### NoDie Setup

###### Edit config.ini files
Edit *src/config.ini* and *src/healer_config.ini* according to your Tibia Client and Character.

### Tibia Setup
###### Edit Bars style
In the game client use Large Bars Style on top, 1 vertical bar on the left and 2 on the right, like so:

![bars_setup](src/img/bars_setup.png)


## Launching
Execute *noDie.ahk*.

## Main Features

### Auto Healer 

##### Feature suspended for Global server
Since an update made in October, 2019, the Tibia client prevents any outside software from reading the game window's pixels.

Reading pixels is the healer's foundation in order to identify character's health and mana and act accordingly.

Until a practical solution is found, this feature can't be used or fixed.

The auto healer will work on OT Servers in which the game client allows the player to take screenshots with the keyboard PrintScreen key.

*NoDie* will track your health and mana bars to take the proper action in order to keep your character safe. It will always take the least expensive action for your current situation, so it allows you to focus on your hunting while wasting less resources.

Use *healer_config.ini* to set up your preferences.

##### Auto HP (for OT server)
*AutoHP* tracks your health bar and executes the least expensive healing spell available.

If healing spells are on cooldown and your health is still low it will use health potions (for knights and paladins) to heal hp.

The healer's description and files will remain in the repository for now, they can be used in Tibia version prior to 10/2019 (in OT Servers for example).

##### Auto MP (for OT server)
*AutoMP* tracks yout mana bar and consumes a mana potions whenever it drops below your defined threshold.

You can also define a maximum threshold, so that if your character surpasses it, it will create a rune. This is done because when hunting, with mana leech while consuming little mana, your character may have superfluous mana which would be better used crafting runes.

##### Auto Heal Paralyze (for OT server)
This feature checks your status box for the paralyze icon and if present, it will cast haste or a healing spell to heal the condition.

It will first check if haste is available, if it is not it will use a healing spell.

##### Auto Haste (for OT server)
Makes sure that your character is always hasted. Whenever it can't find the haste icon in your status bar, it will cast a haste spell. 

### Auto Loot
You can define a hotkey and character coordinates so that you can use this key to loot all squares adjacent to your character.

### Magic Level Training in Protection Zone
As you may know, with some daily rewards you receive the ability to regenerate mana and soul points while in protection zones.

Set up to 4 keys for each of these actions:

- Equip Soft Boots
	- this timer tries to equip your softboots every 5 minutes or so
	- this way you don't have to worry about your soft boots not always having 4 hours of use left
- Equip Ring of Healing
	- this timer can be changed accordingly if you wish to use Life Ring instead
	- Life rings do not offer as much regeneration but are way cheaper
- Eat brown mushrooms
	- other foods may be used, changing the timer accordingly
	- Brown Mushrooms are advised as your character will need to save a lot of capacity for other resources like blank runes and rings
- Use spell to create rune
	- this feature's timer needs to be changed according to each rune in file auto_rune.ahk
	- as is, it uses a proper time to craft sudden death runes (70 to 80 secs)
	- take into consideration how much mana and soul points your character regenerates per sec and how much is needed for your selected rune 
- Use spell to waste excessive mana 
	- if you are consuming more soul points than you regenerate, you will have superfluos mana that you still want to use to increase magic level

With these actions, in a protection zone, your character will safely train magic level while crafting runes and making profit. 

###### Auto login
NoDie features a auto login feature in case your internet connection drops while you are away. 

The bot will **attempt to keep your character selection screen active** and log back in once internet connection is reestablished. By keeping the selection screen active it is able to relogin without inserting your account name and password.

This way you can go to work and be certain that your character will keep training all day long.

###### Works while minimized

These actions will be performed even if your Tibia window is minimized, so you can freely use your computer while your character safely improves its magic level.

Wanna watch a movie or play Dota while still training magic level? With *NoDie* you can do just that!

Keys are sent directly to your Tibia Client, so *NoDie*'s actions will not interfere with anything that you are doing or typing.

#### Tips and Tricks

###### Refill your character
Make sure to refill your character with the necessary resources to keep crafting runes and regenerating mana. For instance, for 24 hours of sudden death making, your character should need:

- 6 to 7 soft boots
- 192 rings of healing
- ~300 brown mushrooms
- ~1k blank runes

###### Try to make a profit

If you sell your runes for the same price as npcs do and buy Rings of Healing for up to 1.5k each, you should be able get some daily profit.

Always renew your buying offers for RoH in market and try to keep their price as low as possible. Do note that, as *NoDie* and other similar bots become common place, RoH demand may increase substantially and, if so, its price will rise.

###### Avoid unnecessary attention
Rent a house with at least one SQM that is not visible from anywhere outside the house and train ML in that spot.

As you might want to stay afk and train ml for hours on end, you don't want other players to notice that your character is standing still and performing repetitive actions.

If other players notice that you are botting, they might report you. This may not always lead to a ban but it is better to avoid it.

###### Remember to deactivate
When you wish to leave protection zone or go hunting, always remember to deactivate the script with the proper hotkey so that the rune maker does not interfere with your gameplay.

###### Training for more than 24 hours
*NoDie* can automatically log in your main character right after server save and get back to magic level training. It can even log all your makers and put them on offline training before logging into your main.

If you want this, set up your account name and password in config.ini. *NoDie* will not send your credentials anywhere but **use it at your own risk**.

If you download *NoDie* or its scripts from an unofficial page, some other developer could easily have edited it so that they have access to your password. Always download *NoDie* from its main, official repository.

This feature is available but not advised unless you know what you are doing.

## Avoiding BattleEye Detection

As BattleEye does not allow bots to be used, every feature in *NoDie* uses some sort of randomness to make it harder for external software to identify any repetitive patterns.

- for some actions, up to 4 keys can be registered. In every call, the corresponding method will randomly select one of these to use.
- the auto-healer's healing period continually changes using *exhaustion_time + small\_random\_number*
- every action has a *very small random delay* before being performed. This delay is unnoticeable for human eyes. 

## Known Bugs
Check the *Issues* Tab for known bugs.


