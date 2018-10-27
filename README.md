# jsfour-dna
A script that lets you grab DNA samples from players and crime scenes (dead players).

### LICENSE
Please don't sell or reupload this resource

### INFO
* Man tar DNAt genom att gå fram till personen och klickar fram menyn (se längre ner)
  - Från en levande spelare räknas DNAt som ett prov, från en död spelare räknas det som en brottsplats
* Du kan endast ha 1 DNA på dig, detta laddas upp nere vid datorn vid cellerna på polishuset
* Man kan ta bort DNA som finns i databasen, då krävs ett lösenord. Lösenordet är hårdkodat och är jsfour by default. Detta kan ändras i init.js på rad 136
* För kunna ta ett DNA från en död spelare så krävs det att spelare dött av ett melee-vapen. En kniv exempelvis. Det är väldigt ologiskt att man kan få fram DNA från en kula. Men är detta något du vill lägga till så kan du göra det i tablen weapons i client.lua
* För att matchningsresultatet ska bli positivt så krävs det att du har DNAt från spelaren i databasen

### INSTALLATION
You need to have <a href="https://github.com/ESX-Org/es_extended">ESX</a> installed.

* Rename the folder to **jsfour-dna**
* Run the SQL file

* To be able to use this script you need to have "lastdigits" in your database. This is something that is used by my other scritps and that's why I've used it here as well. If you don't want it you have to rewrite some of the functions in server.lua. You could use my <a href="https://github.com/jonassvensson4/jsfour-register">jsfour-register<a/> instead of the regular esx_identity to generate lastdigits for every player.

* Add a way to trigger the events, this is a menu for example:

```
{label = 'DNA', value = 'dna'}

if data.current.value == 'dna' then
  local player, distance = ESX.Game.GetClosestPlayer()
  
  if distance ~= -1 and distance <= 3.0 then
    TriggerEvent('jsfour-dna:get', player)
  end
end

-- There's also a remove event which could be added to a menu or something..
TriggerEvent('jsfour-dna:remove')
```

### SCREENSHOTS
![screenshot](https://i.gyazo.com/0e38567915f677da7746ff263a8c74ba.png)
![screenshot](https://i.gyazo.com/72b115711470c1d86c1ced2cc4004fd9.png)
![screenshot](https://i.gyazo.com/54333c35e9eb68b5072ecf572f0ff496.png)
![screenshot](https://i.gyazo.com/654add0e77ed36d03c560943fb6264d8.png)
