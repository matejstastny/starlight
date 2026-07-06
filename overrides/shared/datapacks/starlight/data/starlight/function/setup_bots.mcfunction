# tag
tag Bot1 add this_is_a_bot
tag Bot2 add this_is_a_bot
tag Bot3 add this_is_a_bot
tag Bot4 add this_is_a_bot
tag Bot5 add this_is_a_bot

# grant all advancements to not bloat chat
execute as @e[tag=this_is_a_bot] run advancement grant @s everything

# set skins
execute as @e[tag=this_is_a_bot] run skin set web slim "https://s.namemc.com/i/b801de2a7ac9dc5c.png"

tellraw @a {"text":"[starlight] Bots configured.","color":"green"}
