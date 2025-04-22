local addonName, L = ...; -- Let's use the private table passed to every .lua 

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
	SpellNames.spells = SpellNames.Slowfall
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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("This cannot be undone!")
	L["SettingsClassText"] = "Current Class: %s"
	L["SettingsEnableCheckboxLabel"] = "Enable SlowFaller for this class: "
	L["SettingsCancelCheckboxLabel"] = "Cancel aura if already present: "
	L["SettingsDracthyrCheckboxLabel"] = "Overwrite Dracthyr Glide: "
	L["SettingsSpellInfoNoSpellName"] = "No spell chosen"
	L["SettingsSpellInfoNoSpellDesc"] = "Type in the name or ID of a spell above|nand hit " .. KEY_ENTER .. " to preview the spell."
	L["SettingsOverrideLabel"] = "SlowFaller Spell"
	L["SettingsOverrideTooltip"] = "The spell that will be cast when you activate SlowFaller with a double-jump (or triple-jump for Demon Hunters)."
	L["SettingsOverrideTooltipInstruction"] = "This can be either a spell name or ID."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Reset to Class Defaults"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Reset override configuration to the defaults for your current class."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-CLICK to reset your configuration to the defaults for your current class."
return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["Hello!"] = "¡Hola amigo! El complemento SlowFaller ahora está habilitado en una clase con una habilidad de caída lenta.\nSalta dos veces para activar: " .. SpellNames.spells .. "\nNo funciona en combate ni con montura."
	L["Oh no!"] = "¡Hola amigo! Este mensaje está aquí para informarte que el complemento SlowFaller está habilitado en una clase sin una habilidad de caída lenta, por lo tanto, no ejecutará ningún código.\nRequiere: " .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
	 -- (old) official translation above (thanks to twitter @RomanValoppi )
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("¡Esto no se puede deshacer!")
	L["SettingsClassText"] = "Clase actual: %s"
	L["SettingsEnableCheckboxLabel"] = "Habilitar SlowFaller para esta clase: "
	L["SettingsCancelCheckboxLabel"] = "Cancelar aura si ya está presente: "
	L["SettingsDracthyrCheckboxLabel"] = "Reemplazar planeo de Dracthyr: "
	L["SettingsSpellInfoNoSpellName"] = "Ningún hechizo elegido"
	L["SettingsSpellInfoNoSpellDesc"] = "Escribe el nombre o ID de un hechizo arriba|ny presiona " .. KEY_ENTER .. " para previsualizar el hechizo."
	L["SettingsOverrideLabel"] = "Hechizo de SlowFaller"
	L["SettingsOverrideTooltip"] = "El hechizo que se lanzará cuando actives SlowFaller con un doble salto (o triple salto para los cazadores de demonios)."
	L["SettingsOverrideTooltipInstruction"] = "Puede ser un nombre de hechizo o un ID."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Restablecer valores predeterminados de clase"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Restablecer la configuración personalizada a los valores predeterminados de tu clase actual."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-CLIC para restablecer tu configuración a los valores predeterminados de tu clase actual."

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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("Dies kann nicht rückgängig gemacht werden!")
	L["SettingsClassText"] = "Aktuelle Klasse: %s"
	L["SettingsEnableCheckboxLabel"] = "SlowFaller für diese Klasse aktivieren: "
	L["SettingsCancelCheckboxLabel"] = "Aura abbrechen, wenn bereits vorhanden: "
	L["SettingsDracthyrCheckboxLabel"] = "Dracthyr-Gleiten überschreiben: "
	L["SettingsSpellInfoNoSpellName"] = "Kein Zauber ausgewählt"
	L["SettingsSpellInfoNoSpellDesc"] = "Gib oben den Namen oder die ID eines Zaubers ein|nund drücke " .. KEY_ENTER .. ", um eine Vorschau zu sehen."
	L["SettingsOverrideLabel"] = "SlowFaller-Zauber"
	L["SettingsOverrideTooltip"] = "Der Zauber, der ausgelöst wird, wenn du SlowFaller mit einem Doppelsprung (oder Dreifachsprung für Dämonenjäger) aktivierst."
	L["SettingsOverrideTooltipInstruction"] = "Dies kann ein Zaubername oder eine ID sein."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Auf Klassenvorgaben zurücksetzen"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Überschreibungen auf die Standardwerte deiner aktuellen Klasse zurücksetzen."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-KLICK zum Zurücksetzen der Konfiguration auf Standardwerte deiner aktuellen Klasse."
return end

if LOCALE == "frFR" then
	-- French translations go here
	L["Hello!"] = "Salut l'ami! L'addon SlowFaller est maintenant activé sur une classe avec une capacité de chute lente.\nFaites un double saut pour activer: " .. SpellNames.spells .. "\nNe fonctionne pas en combat ou à cheval."
	L["Oh no!"] = "Salut l'ami! Ce message est là pour vous informer que l'addon SlowFaller est activé sur une classe sans capacité de chute lente, et n'exécutera donc aucun code.\nRequiert: "  .. SpellNames.spells
	L["Name"] = "SlowFaller"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
	 -- (old) official translation above (thanks to twitter @Solanya_ )
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("Ceci ne peut pas être annulé !")
	L["SettingsClassText"] = "Classe actuelle : %s"
	L["SettingsEnableCheckboxLabel"] = "Activer SlowFaller pour cette classe : "
	L["SettingsCancelCheckboxLabel"] = "Annuler l’aura si déjà présente : "
	L["SettingsDracthyrCheckboxLabel"] = "Remplacer le vol plané Dracthyr : "
	L["SettingsSpellInfoNoSpellName"] = "Aucun sort choisi"
	L["SettingsSpellInfoNoSpellDesc"] = "Tapez le nom ou l’ID d’un sort ci-dessus|net appuyez sur " .. KEY_ENTER .. " pour prévisualiser le sort."
	L["SettingsOverrideLabel"] = "Sort SlowFaller"
	L["SettingsOverrideTooltip"] = "Le sort qui sera lancé lorsque vous activez SlowFaller avec un double-saut (ou triple-saut pour les chasseurs de démons)."
	L["SettingsOverrideTooltipInstruction"] = "Cela peut être un nom de sort ou un ID."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Réinitialiser les paramètres par défaut de la classe"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Réinitialiser la configuration de remplacement aux valeurs par défaut de votre classe actuelle."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-CLIC pour réinitialiser la configuration aux valeurs par défaut de votre classe actuelle."
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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("Questa operazione non può essere annullata!")
	L["SettingsClassText"] = "Classe attuale: %s"
	L["SettingsEnableCheckboxLabel"] = "Abilita SlowFaller per questa classe: "
	L["SettingsCancelCheckboxLabel"] = "Annulla l’aura se già presente: "
	L["SettingsDracthyrCheckboxLabel"] = "Sostituisci planata Dracthyr: "
	L["SettingsSpellInfoNoSpellName"] = "Nessun incantesimo selezionato"
	L["SettingsSpellInfoNoSpellDesc"] = "Digita il nome o l’ID di un incantesimo qui sopra|ne premi " .. KEY_ENTER .. " per visualizzarne l’anteprima."
	L["SettingsOverrideLabel"] = "Incantesimo SlowFaller"
	L["SettingsOverrideTooltip"] = "L’incantesimo che verrà lanciato quando attivi SlowFaller con un doppio salto (o triplo salto per i Cacciatori di Demoni)."
	L["SettingsOverrideTooltipInstruction"] = "Può essere un nome o un ID di incantesimo."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Ripristina predefiniti della classe"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Ripristina la configurazione ai valori predefiniti della tua classe attuale."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-CLIC per ripristinare la configurazione ai predefiniti della tua classe attuale."
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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("Isso não pode ser desfeito!")
	L["SettingsClassText"] = "Classe atual: %s"
	L["SettingsEnableCheckboxLabel"] = "Ativar SlowFaller para esta classe: "
	L["SettingsCancelCheckboxLabel"] = "Cancelar aura se já presente: "
	L["SettingsDracthyrCheckboxLabel"] = "Substituir planar de Dracthyr: "
	L["SettingsSpellInfoNoSpellName"] = "Nenhuma magia selecionada"
	L["SettingsSpellInfoNoSpellDesc"] = "Digite o nome ou ID de uma magia acima|ne pressione " .. KEY_ENTER .. " para visualizar a magia."
	L["SettingsOverrideLabel"] = "Magia do SlowFaller"
	L["SettingsOverrideTooltip"] = "A magia que será lançada quando você ativar o SlowFaller com um pulo duplo (ou triplo para Caçadores de Demônios)."
	L["SettingsOverrideTooltipInstruction"] = "Pode ser o nome ou o ID da magia."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Redefinir para padrão da classe"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Redefine a configuração personalizada para os padrões da sua classe atual."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-CLIQUE para redefinir a configuração para os padrões da sua classe atual."
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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("Это действие нельзя отменить!")
	L["SettingsClassText"] = "Текущий класс: %s"
	L["SettingsEnableCheckboxLabel"] = "Включить SlowFaller для этого класса: "
	L["SettingsCancelCheckboxLabel"] = "Отменить ауру, если уже наложена: "
	L["SettingsDracthyrCheckboxLabel"] = "Заменить планирование драктиров: "
	L["SettingsSpellInfoNoSpellName"] = "Заклинание не выбрано"
	L["SettingsSpellInfoNoSpellDesc"] = "Введите название или ID заклинания выше|nи нажмите " .. KEY_ENTER .. " для предварительного просмотра."
	L["SettingsOverrideLabel"] = "Заклинание SlowFaller"
	L["SettingsOverrideTooltip"] = "Заклинание, которое будет применено при активации SlowFaller двойным прыжком (или тройным для охотников на демонов)."
	L["SettingsOverrideTooltipInstruction"] = "Может быть названием заклинания или его ID."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "Сбросить к настройкам класса"
	L["SettingsDefaultsButtonTooltipEnabled"] = "Сбросить настройки замены к значениям по умолчанию для текущего класса."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-КЛИК для сброса настроек к значениям по умолчанию."
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
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("이 작업은 되돌릴 수 없습니다!")
	L["SettingsClassText"] = "현재 클래스: %s"
	L["SettingsEnableCheckboxLabel"] = "이 클래스에 SlowFaller 사용: "
	L["SettingsCancelCheckboxLabel"] = "오라가 이미 있으면 취소: "
	L["SettingsDracthyrCheckboxLabel"] = "드랙티르 활공 덮어쓰기: "
	L["SettingsSpellInfoNoSpellName"] = "선택된 주문 없음"
	L["SettingsSpellInfoNoSpellDesc"] = "위에 주문 이름 또는 ID를 입력하고|n" .. KEY_ENTER .. " 키를 눌러 미리보기를 확인하세요."
	L["SettingsOverrideLabel"] = "SlowFaller 주문"
	L["SettingsOverrideTooltip"] = "SlowFaller를 더블 점프로 활성화하면 시전할 주문입니다 (악마 사냥꾼은 트리플 점프)."
	L["SettingsOverrideTooltipInstruction"] = "주문 이름이나 주문 ID를 사용할 수 있습니다."
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "클래스 기본값으로 초기화"
	L["SettingsDefaultsButtonTooltipEnabled"] = "현재 클래스의 기본 설정으로 덮어쓰기 구성을 초기화합니다."
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-클릭으로 현재 클래스의 기본값으로 설정 초기화"
return end

if LOCALE == "zhCN" then
	-- Simplified Chinese translations go here
	L["Hello!"] = "嗨！ SlowFaller 已启用，现在可将缓落技能关联至二段跳。二段跳关联法术：" .. SpellNames.spells .. "\n在战斗或骑乘时不起作用。"
	L["Oh no!"] = "嗨！ SlowFaller 已停用，因为你目前在玩的职业没有缓落技能。\n二段跳关联法术：" .. SpellNames.spells
	L["Name"] = "SlowFaller：二段跳缓落术"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
	 -- (old) official translation above (thanks to github @EKE00372)
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("此操作无法撤销！")
	L["SettingsClassText"] = "当前职业：%s"
	L["SettingsEnableCheckboxLabel"] = "为该职业启用 SlowFaller："
	L["SettingsCancelCheckboxLabel"] = "若已有光环则取消："
	L["SettingsDracthyrCheckboxLabel"] = "覆盖半龙人滑翔："
	L["SettingsSpellInfoNoSpellName"] = "未选择技能"
	L["SettingsSpellInfoNoSpellDesc"] = "在上方输入技能名称或 ID|n并按下 " .. KEY_ENTER .. " 来预览技能效果。"
	L["SettingsOverrideLabel"] = "SlowFaller 技能"
	L["SettingsOverrideTooltip"] = "激活 SlowFaller（双跳，恶魔猎手为三跳）时将施放的技能。"
	L["SettingsOverrideTooltipInstruction"] = "可以是技能名称或 ID。"
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "重置为职业默认值"
	L["SettingsDefaultsButtonTooltipEnabled"] = "重置当前职业的覆盖配置为默认值。"
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-点击以重置为当前职业默认配置。"
return end

if LOCALE == "zhTW" then
	-- Traditional Chinese translations go here
	L["Hello!"] = "嗨！ SlowFaller 已啟用，現在可將緩落技能關聯至二段跳。關聯法術：" .. SpellNames.spells .. "\n在戰鬥或騎乘時不起作用。"
	L["Oh no!"] = "嗨！ SlowFaller 已停用，因為你目前在玩的職業沒有緩落技能。\n二段跳關聯法術：" .. SpellNames.spells
	L["Name"] = "SlowFaller：二段跳緩落術"
	L["Flight Form"] = Flightform
	L["Flap"] = Flap
	L["Slow Fall"] = Slowfall
	L["Levitate"] = Levitate
	 -- (old) official translation above (thanks to github @EKE00372)
	L["ThisCannotBeUndone"] = RED_FONT_COLOR:WrapTextInColorCode("此操作無法還原！")
	L["SettingsClassText"] = "目前職業：%s"
	L["SettingsEnableCheckboxLabel"] = "啟用此職業的 SlowFaller："
	L["SettingsCancelCheckboxLabel"] = "若已有光環則取消："
	L["SettingsDracthyrCheckboxLabel"] = "覆蓋半龍人滑翔："
	L["SettingsSpellInfoNoSpellName"] = "尚未選擇技能"
	L["SettingsSpellInfoNoSpellDesc"] = "請在上方輸入技能名稱或 ID|n並按下 " .. KEY_ENTER .. " 來預覽技能。"
	L["SettingsOverrideLabel"] = "SlowFaller 技能"
	L["SettingsOverrideTooltip"] = "啟動 SlowFaller（雙跳，惡魔獵人為三跳）時會施放的技能。"
	L["SettingsOverrideTooltipInstruction"] = "可以是技能名稱或技能 ID。"
	L["SettingsSaveButtonLabel"] = SAVE
	L["SettingsDefaultsButtonLabel"] = "重設為職業預設值"
	L["SettingsDefaultsButtonTooltipEnabled"] = "將目前職業的覆寫設定重設為預設值。"
	L["SettingsDefaultsButtonTooltipDisabled"] = SHIFT_KEY_TEXT .. "-點擊以重設目前職業的預設配置。"
return end
