# Typocracy

## Uppgift: 
Skapa en iOS-app i Swift och UIKit som är ett snabbskrivningsspel där ord dyker upp allt eftersom spelaren klarar av dem.

## Beskrivning:
Din uppgift är att skapa en iOS-app i Swift och UIKit som är ett snabbskrivningsspel där spelaren måste skriva ord så snabbt som möjligt. Spelet ska ha en lista med ord som inte visas på en gång, utan dyker upp allt eftersom spelaren klarar av dem.

### Godkänd
- [x] Spelet måste ha en startskärm som innehåller en knapp för att starta spelet. ✅ 2023-03-20
- [x] När spelet startar visas det första ordet på skärmen. ✅ 2023-03-21
- [x] Spelaren har en viss tid att skriva varje ord, exempelvis 5 sekunder. Om spelaren skriver ordet innan tiden går ut får den poäng, annars förlorar spelaren poäng. ✅ 2023-03-21
- [x] När spelaren skrivit ordet dyker nästa ord upp på skärmen. ✅ 2023-03-21
- [x] Spelet ska ha en poängtavla som visar spelarens aktuella poäng. ✅ 2023-03-21
- [x] Spelet ska ha en slutskärm som visar spelarens totala poäng och en knapp för att spela igen. ✅ 2023-03-23
- [x] För att skapa spelet behöver du använda Swift och UIKit för att designa appens användargränssnitt och logik. ✅ 2023-03-21

### Väl Godkänd
För att få VG krävs det att du också implementerar följande funktioner:
- [x] Spelaren ska kunna välja svårighetsgrad, exempelvis antal ord eller tid per ord. ✅ 2023-03-24
- [x] Spelet ska ha en highscore-lista där spelarens bästa resultat sparas (använd user default) ✅ 2023-03-28
- [x] Koden är strukturerad efter MVC ✅ 2023-03-21

### MVC TODO
- [x] GameVC ✅ 2023-03-29
- [x] ScoreboardVC ✅ 2023-03-29
- [x] Scoreboard Model ✅ 2023-03-29
- [x] ScoreboardEntry Model ✅ 2023-03-29
- [x] Game Model ✅ 2023-03-29

#### TODO/FIXME
- [x] Skapa ordlistan ✅ 2023-03-23
- [x] Victory conditions: game ends when each word has been displayed once ✅ 2023-03-27
- [x] Skapa ordlistor motsvarande svårighetsgrad ✅ 2023-03-24
- [x] Utforska User Defaults ✅ 2023-03-27
- [x] Timer går för fort ✅ 2023-03-27
- [x] Varför stannar timern ibland? ✅ 2023-03-28
- [x] Sista bokstaven i inputrutan ✅ 2023-03-30
