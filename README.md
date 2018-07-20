# jsfour-dna
Ett script som låter dig ta DNA från alla spelare samt brottsplatser (döda spelare).

### LICENSE
Du får mer än gärna ändra vad du vill i scriptet men du får INTE sälja vidare scriptet eller ladda upp det på nytt, hänvisa folket hit istället.

### INFO
För att scriptet ska fungera så behöver du använda dig av ESX.

* Man tar DNAt genom att gå fram till personen och klickar fram menyn (se längre ner)
  - Från en levande spelare räknas DNAt som ett prov, från en död spelare räknas det som en brottsplats
* Du kan endast ha 1 DNA på dig, detta laddas upp nere datorn vid cellerna på polishuset
* Man kan ta bort DNA som finns i databasen, då krävs ett lösenord. Lösenordet är hårdkodat och är jsfour by default. Detta kan ändras i init.js på rad 136
* För kunna ta ett DNA från en död spelare så krävs det att spelare dött av ett melee-vapen. En kniv exempelvis. Det är väldigt ologiskt att man kan få fram DNA från en kula. Men är detta något du vill lägga till så kan du göra det i tablen weapons i client.lua
* För att matchningsresultatet ska bli positivt så krävs det att du har DNAt från spelaren i databasen

### INSTALLERING
För att detta ska fungera behöver du göra följande:

1. Lägg in scriptet i din resource-mapp och lägg sedan till den i din server.cfg så den startas
2. Lägg in tabellen i databasen (jsfour_dna.sql)
3. Detta lägger du till i din polis-meny:

```
{label = 'DNA', value = 'dna'}

if data.current.value == 'dna' then
  local player, distance = ESX.Game.GetClosestPlayer()
  
  if distance ~= -1 and distance <= 3.0 then
    TriggerEvent('jsfour-dna:get', player)
  end
end

-- Finns även ett event för att ta bort DNAt du har på dig. Även detta rekommenderas att ha i en meny
TriggerEvent('jsfour-dna:remove')
```

### SCREENSHOTS
![screenshot](https://i.gyazo.com/0e38567915f677da7746ff263a8c74ba.png)
![screenshot](https://i.gyazo.com/72b115711470c1d86c1ced2cc4004fd9.png)
![screenshot](https://i.gyazo.com/54333c35e9eb68b5072ecf572f0ff496.png)
![screenshot](https://i.gyazo.com/654add0e77ed36d03c560943fb6264d8.png)
