# Uppstart
Hej och välkommen till detta Hackathon! I denna readme har vi samlat den information som ni ska behöva för att tackla det praktiskt runt uppgiften.
Agendan för dessa dagar finns i ett dokument som heter Agenda.pptx.
Ni som team jobbar i detta repo under denna tid. Vi i PL gruppen kommer att titta i repot under dagarnas gång och även kolla i det när vi ska utvärdera vinnarna det är därför viktigt att allt arbete sker här så att allt är på samma plats.

Ett tips till teamet är att gå varvet runt och låta alla presentera sig, ni kan utgå från detta ifall ni vill:
* Vem är du?
* Vad heter du?
* Vart jobbar du och vad jobbar du med?
* Vad har du gjort innan din nuvarande anställning?
* Vilka tekniker jobbar du mest med idag?
* Är det något under dessa dagar som du redan nu vet att du skulle vilja undersöka mera?

# För att klona repo
Github har tagit bort stödet för användarnamn och lösenord över HTTPS så ni behöver skapa ett PersonalAccessToken(PAT).
Gå in under Settings i rullisten uppe i högra hörnet på eran profil. Längst ner i Settings listan finns Developer Settings, klicka på den. Klicka sedan på Personal acces tokens. Klicka sedan på Generate new token. Ge ditt token ett namn och bocka för repo kryssrutan.
Detta skapar ett token med korrekt OAuth scope och du kan nu klona repot genom att tex köra: git clone https://< token >@github.com/Addnode-Hackaton-2022/Team-3.git

### Första uppgifterna till teamet, deadline dag 1 kl 11:00. Svara direkt i denna readme i punkterna under.
* Gå igenom pp Agenda.pptx
* Gå varvet runt och presentera era enligt frågorna ovan.
* Välj en teamleader för erat team.
  - Teamleader - Emil Goude
* Välj ett namn för erat team. Detta skall även skrivas på dörren.
  - Namn - Team Antimon
* Vilken utmaning jobbar ni med?
  - Namn - Strömmad video med korrekt telemetrilog
 
 
 ### Andra uppgiften, deadline dag 2 kl 12:30
 * Ett inskick där ni ska fylla på denna readme med information under avsnittet Inskick, deadline dag två kl 13:00
 * En muntlig presentation där ni får presentera eran uppgift.
 * Lösningen som ni jobbat på under dessa dagar.

Det är på dessa moment som eran uppgift blir bedömd.

### Vad händer efter hackatonet?
En vecka efter hackatonet kommer alla repon att göras publika.

# Viktiga tider
### Dag 1 kl 11:00 - Deadline uppstart
### Dag 1 kl 12:00 - Lunch
### Dag 1 kl 18:30 - Middag
### Dag 2 kl 08:00 - Uppsamling H4, dagen startar
### Dag 2 kl 11:00 - Lunch
### Dag 2 kl 12:30 - Deadline för uppgiften. 
Här skall sista commiten till repot vara gjord och den muntliga presentationen vara klar för redovisning.
### Dag 2 kl 15:00 - Hackaton avslutas med mingel för de som har möjlighet

# Inskick, deadline dag två kl 12:30

### Övergripande beskrivning och val av utmaning
  - Strömmad video med korrekt telemetrilog. Det gick ut på att lägga till vinklarna på gimbalen för kameran i
    utströmmen (utströmmarna) för att nästa team ska kunna använda den infromationen för att stabilisera videoströmmen.

### Team Antimon

#### Namn på medlemmar 
* Gabriel Aunan (Decisive AS)
* Emil Goude (Sokigo AB)
* Mattias Lanzén (Symetri AB)
* Markus Meder (Decerno AB)
* Daniel Svennberg (Ida Infront AB)
* Toomas Vaks (TECHNIA AB)
* Charlotte Viktorsson (S-Group Solutions AB)

#### Hur har ni jobbat inom teamet? Har alla gjort samma eller har ni haft olika roller?

Vi har planerat tillsammans och sedan med olika uppgifter två och två eller tre och tre.

### Teknik. Beskrivningen på eran teknikstack, språk och APIer ni har använt.
powershell rpanion mavlink-router quaternion-bibliotek (för att räkna ut vinklar)
Vi har diskuterad huruvida vi ska lägga till data om vinklarna i RTSP strömmen eller om vi ska ha en
separat ström med extra-informationen. Just nu lutar det åt två strömmar.

### Lösning, dessa frågor ska minst besvaras
 * Hur har ni löst utmaningen?
 ** Vi har inte kommit fram till en lösning. Men vi har idéer som vi har presenterat ovan.
    Vi skulle kunna skippa rpanion och bara använda oss av mavlink-router.
 * Hur långt har ni kommit?
 ** Vi experimenterar med att få ut två strömmar enligt beskrivning ovan.
 * Vad är nästa steg?
 ** Fortsätta experimentet.
 * Några rekommendationer för framtiden?
 ** Vi vet ännu inte vilken väg som är bäst. Rpanion kanske inte behövs utan det räcker med mavlink.
    Hurvida vi kan baka in informationen i rtspstömmen eller skicka den som en separat ström återstår att reda ut.
 * Några insikter, begränsningar eller utmaningar ni stött på som är intressanta att dela med der av?
 ** Rpanion skickar data en gång i sekunden vilket förmodligen är för sällan. En egen lösning med mavlink borde kunns skicka oftare.


# Mall för muntlig presentation, deadline dag två kl 12:30
Den totala tiden av presentation får ni distribuera som ni vill men den måste hållas. Presentation i form av text skall vara i en powerpoint medans demo visar ni som ni vill. Tänk bara på att ni ska hinna på utsatt tid.
* Överblick och utmaning - 1min
  - En mening ang vad lösningen gör
  - Vilken utmaning har ni tacklat?
* Team - 1min
  - Vilka är ni i erat team?
  - Vilka roller har ni haft? Hur har ni jobbat tillsammans?
* Teknik - 1min
  - Vilka tekniker har ni använt?
* Lösning och Demo - 2min 30s
  - Demo
  - Hur löser ni denna utmaning?
  - Vad är nästa steg, rekommendationer för framtiden?
