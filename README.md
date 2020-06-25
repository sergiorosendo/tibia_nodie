# Tibia NoDie
*NoDie* features macros, shortcuts and auto-healers for the PC game Tibia. Created with AutoHotkey, an automation scripting language for Windows.

These ahk scripts were developed for my personal use. I've used and improved them for over a year and never had issues with bans or BattleEye.

I am not playing Tibia anymore but, as I did put a lot of effort into understanding AHK and developing this, I'm sharing it for public use and maybe to colaborate with other AHK developers to improve it.

##### License

Feel free to edit and share it yourself, but give credit where credit is due.

## Main Features

### Auto Healer
*NoDie* will track your health and mana bars to take the proper action in order to keep your character safe. It will always take the least expensive action for your current situation, so it allows you to focus on your hunting while wasting less resources.

Use *healer_config.ini* to set up your preferences.

##### Auto HP
*AutoHP* tracks your health bar and executes the least expensive healing spell available.

If healing spells are on cooldown and your health is still low it will use health potions (for knights and paladins) to heal hp.

##### Auto MP
*AutoMP* tracks yout mana bar and consumes a mana potions whenever it drops below your defined threshold.

You can also define a maximum threshold, so that if your character surpasses it, it will create a rune. This is done because when hunting, with mana leech while consuming little mana, your character may have superfluous mana which would be better used crafting runes.

##### Auto Heal Paralyze
This feature checks your status box for the paralyze icon and if present, it will cast haste or a healing spell to heal the condition.

It will first check if haste is available, if it is not it will use a healing spell.

##### Auto Haste
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
- in some very rare occasions the bot may "freeze" your keyboard for up to ~30 secs. 
	- If you are hunting when this happens, this may cause your character to die, so keep it in mind.
	- it is a rare event, but it can happen. 
	- it was only experienced a few times and, in most cases, I was able to take control back before dying
	- the cause for this bug is still unknown, once it is figured out, it should be fixed eventually
	- as always, use *NoDie* at your own risk
- sometimes the afk ml trainer may fail to send keys for a certain action for a period of an hour or so and then get back to normal
	- this is somewhat annoying but does not cause major issues
	- even if it does happens, this goes away without the need for any actions and your character won't stop making runes
	- the cause for this bug is still unknown, once it is figured out, it should be fixed eventually

## ToDo

##### Source Code 
- Logically separate files in different folders
	- requires editing paths used in some *#include* statements
		- requires defining a new method to get parent folder, apparently ahk does not have a shortcut for this
- Rewrite the code in Python
	- requires checking if BattleEye allows Python libraries to perform the same tasks as AHK scripts
	
##### Interface
- Create a user friendly GUI interface
	- Maybe using Python + AHK

##### Specific methods
- Add a method to identify the current screen's size and the game window's size and coordinates 
	- currently this uses a specific screen coordinates, so it won't work in every machine unless the values are changed manually
- For any method that uses windows coordinates, make it take into consideration the current window size and use proportions to identify the correct coordinates for any window
	- currently these methods use specific coordinates, so may not work in every machine

##### Druids
- Auto sio
	- read knight's health from the battle list

##### Paladins:
- auto create diamond arrows

##### Knights:
- shortcut to execute aggressive spells rotation

##### Sorcerers 
- ~

##### Misc
- Check if BattleEye still allows ahk executables to run
	- This was developed for personal use in 2019. BattleEye was not able to detect it them.

- Include installation instructions

- Create Manual
