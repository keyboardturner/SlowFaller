local SlowFaller, L = ...; -- Let's use the private table passed to every .lua 

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

local SpellNames = {

Flightform = "\124cffffd000\124Hspell:276029\124h[" .. Spell:CreateFromSpellID(276029):GetSpellName() .. "]\124h\124r",
Flap = "\124cffffd000\124Hspell:164862\124h[" .. Spell:CreateFromSpellID(164862):GetSpellName() .. "]\124h\124r",
Slowfall = "\124cffffd000\124Hspell:130\124h[" .. Spell:CreateFromSpellID(130):GetSpellName() .. "]\124h\124r",
Levitate = "\124cffffd000\124Hspell:1706\124h[" .. Spell:CreateFromSpellID(1706):GetSpellName() .. "]\124h\124r",

};

SpellNames.class = select(2, UnitClassBase("player"))

if SpellNames.class == 5 then -- priest
	SpellNames.spells = SpellNames.Levitate
elseif SpellNames.class == 8 then -- mage
	SpellNames.spells = SpellNames.Levitate
--[[
elseif SpellNames.class == 10 then -- monk
	SpellNames.spells = SpellNames.Levitate
]]
elseif SpellNames.class == 11 then -- druid
	SpellNames.spells = SpellNames.Flap --SpellNames.Flightform .. ", " .. 
else
	SpellNames.spells = SpellNames.Flap .. ", " .. SpellNames.Slowfall .. ", " .. SpellNames.Levitate --SpellNames.Flightform .. ", " .. 
end

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["Hello!"] = "Hello friend! The SlowFaller addon is now enabled on a class with a slow fall ability.\nDouble-jump to activate: " .. SpellNames.spells .. "\nDoes not work in combat or while mounted."
	L["Oh no!"] = "Hello friend! This message is here to let you know that the SlowFaller addon is enabled on a class without a slow fall ability, and therefore will not be running any code.\nRequires: " .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "esES" or LOCALE == "esMX" then -- official translation (thanks to twitter @RomanValoppi )
	-- Spanish translations go here
	L["Hello!"] = "¡Hola amigo! El complemento SlowFaller ahora está habilitado en una clase con una habilidad de caída lenta.\nSalta dos veces para activar: " .. SpellNames.spells .. "\nNo funciona en combate ni con montura."
	L["Oh no!"] = "¡Hola amigo! Este mensaje está aquí para informarte que el complemento SlowFaller está habilitado en una clase sin una habilidad de caída lenta, por lo tanto, no ejecutará ningún código.\nRequiere: " .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "deDE" then
	-- German translations go here
	L["Hello!"] = "Hallo Freund! Das SlowFaller-Addon ist jetzt für eine Klasse mit der Fähigkeit „Slow Fall“ aktiviert.\nFührt einen Doppelsprung aus: " .. SpellNames.spells .. "\nFunktioniert nicht im Kampf oder auf einem Pferd."
	L["Oh no!"] = "Hallo Freund! Diese Nachricht soll Sie darüber informieren, dass das SlowFaller-Addon für eine Klasse ohne Slow-Fall-Fähigkeit aktiviert ist und daher keinen Code ausführt.\nBenötigt: "  .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "frFR" then -- official translation (thanks to twitter @Solanya_ )
	-- French translations go here
	L["Hello!"] = "Salut l'ami! L'addon SlowFaller est maintenant activé sur une classe avec une capacité de chute lente.\nFaites un double saut pour activer: " .. SpellNames.spells .. "\nNe fonctionne pas en combat ou à cheval."
	L["Oh no!"] = "Salut l'ami! Ce message est là pour vous informer que l'addon SlowFaller est activé sur une classe sans capacité de chute lente, et n'exécutera donc aucun code.\nRequiert: "  .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "itIT" then
	-- French translations go here
	L["Hello!"] = "Ciao amico! L'addon SlowFaller è ora abilitato su una classe con un'abilità di caduta lenta.\nDoppio salto per attivare: " .. SpellNames.spells .. "\nNon funziona in combattimento o in sella."
	L["Oh no!"] = "Ciao amico! Questo messaggio è qui per farti sapere che l'addon SlowFaller è abilitato su una classe senza una capacità di caduta lenta, e quindi non eseguirà alcun codice.\nRichiede: "  .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["Hello!"] = "Olá amiga! O complemento SlowFaller agora está habilitado em uma classe com uma habilidade de queda lenta.\nDê um salto duplo para ativar: " .. SpellNames.spells .. "\nNão funciona em combate ou montado."
	L["Oh no!"] = "Olá amiga! Esta mensagem está aqui para informar que o addon SlowFaller está ativado em uma classe sem uma capacidade de queda lenta e, portanto, não executará nenhum código.\nRequer: "  .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["Hello!"] = "Привет друг! Надстройка двойной-прыжок-замедленное-падение теперь включена для класса со способностью медленного падения.\nДвойной прыжок для активации: " .. SpellNames.spells .. "\nНе работает в бою или верхом."
	L["Oh no!"] = "Привет друг! Это сообщение здесь, чтобы сообщить вам, что надстройка двойной-прыжок-замедленное-падение включена для класса без возможности медленного падения, и поэтому не будет запускать какой-либо код.\nТребуется: "  .. SpellNames.spells
	L["Name"] = "двойной прыжок замедленное падение"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["Hello!"] = "안녕 친구! 이중-도약저속-낙하 애드온은 이제 느린 낙하 능력이 있는 클래스에서 활성화됩니다.\n두 번 점프하여 활성화: " .. SpellNames.spells .. "\n전투 중이나 탈것에 탄 상태에서는 작동하지 않습니다."
	L["Oh no!"] = "안녕 친구! 이 메시지는 느린 낙하 기능이 없는 클래스에서 이중-도약저속-낙하 애드온이 활성화되어 있으므로 어떤 코드도 실행하지 않을 것임을 알려드리기 위해 여기에 있습니다.\n필요: " .. SpellNames.spells
	L["Name"] = "이중 도약 저속 낙하"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["Hello!"] = "你好朋友！ 二段跳缓落术 插件现在在具有缓慢下降能力的类上启用。\n双跳激活： " .. SpellNames.spells .. "\n在战斗或骑乘时不起作用。"
	L["Oh no!"] = "你好朋友！ 这条消息是为了让您知道 二段跳缓落术 插件在没有缓慢下降能力的类上启用，因此不会运行任何代码。\n需要: " .. SpellNames.spells
	L["Name"] = "二段跳缓落术"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["Hello!"] = "你好朋友！ 二段跳缓落术 插件現在在具有緩慢下降能力的類上啟用。 双跳激活： " .. SpellNames.spells .. "\n在戰鬥或騎乘時不起作用。"
	L["Oh no!"] = "你好朋友！ 這條消息是為了讓您知道 二段跳缓落术 插件在沒有緩慢下降能力的類上啟用，因此不會運行任何代碼。\n需要: " .. SpellNames.spells
	L["Name"] = "二段跳缓落术"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
return end
