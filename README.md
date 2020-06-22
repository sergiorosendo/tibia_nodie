# tibia\_ahk_tools
Some macros, shortcuts and auto-healers for the PC game Tibia. Created with AutoHotkey, an automation scripting language for Windows.

These ahk scripts were developed for my personal use. I've used and improved them for a year and never had issues with bans or BattleEye.

I am not playing Tibia anymore but, as I did put a lot of effort into understanding AHK and developing this, I'm sharing it for public use and maybe to colaborate with other AHK developers to improve it.

As BattleEye does not allow bots to be used, every feature in this project uses some sort of randomness to make it harder for external software to identify any patterns.

- for some actions, up to 4 keys can be registered. In every call, the corresponding method will randomly select one of these to use
- the auto-healer's healing period changes continually using *exhaustion_time + small\_random\_number*

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
- x


##### Misc
- Check if BattleEye still allows ahk executables to run
	- This was developed for personal use in 2019. BattleEye was not able to detect it them.

- Define this program's official name xD