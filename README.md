# jsfour-dna
A script that lets you grab DNA samples from players and crime scenes (dead players).

### LICENSE
Please don't sell or reupload this resource

### INSTALLATION
You need to have <a href="https://github.com/ESX-Org/es_extended">ESX</a> installed.

* Rename the folder to **jsfour-dna**
* Run the SQL file
* To be able to use this script you need to have "lastdigits" in your database. This is something that is used by my other scritps and that's why I've used it here as well. If you don't want it you have to rewrite some of the functions in server.lua. You could use my <a href="https://github.com/jonassvensson4/jsfour-register">jsfour-register<a/> instead of the regular esx_identity to generate lastdigits for every player.
* Grab the DNA by using this code, you need to add it to a menu or something:

```
  local player, distance = ESX.Game.GetClosestPlayer()
  
  if distance ~= -1 and distance <= 3.0 then
    TriggerEvent('jsfour-dna:get', player)
  end

  -- There's also a remove event which could be added to a menu or something..
  TriggerEvent('jsfour-dna:remove')
```

### USAGE
* Grab a DNA by using the example below. 
  - If you grab a DNA sample from a player that's alive it counts as a "person" if you grab it from a dead player it counts as a "crime scene"

* You can only have 1 DNA on you at a time. So you need to upload it at the computer at the police station (down the stairs) Or use my <a href="https://github.com/jonassvensson4/jsfour-mdc">jsfour-mdc</a>
* You can remove a DNA that's in the database, you'll need a password. The password is jsfour by default. This could be changed in init.js on row 136
* To be able to grab a DNA from a dead player the player needs to have been killed by a melee weapon, a knife and so on. It wouldn't be that realistic if you could grab a DNA if the player had been killed by a gun. If you wan't to add more weapons you could do so by adding them in the weapons table in client.lua
* For a successful match you need to have the persons DNA in the database

### SCREENSHOTS
![screenshot](https://i.gyazo.com/0e38567915f677da7746ff263a8c74ba.png)
![screenshot](https://i.gyazo.com/72b115711470c1d86c1ced2cc4004fd9.png)
![screenshot](https://i.gyazo.com/54333c35e9eb68b5072ecf572f0ff496.png)
![screenshot](https://i.gyazo.com/654add0e77ed36d03c560943fb6264d8.png)
