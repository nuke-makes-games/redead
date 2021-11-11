--[[
ReDead Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. <p style=</p>, %s. Keep those directly.
3. Keep translations short and concise.
4. Translate AS IS.
--]]

translate.AddLanguage("ru", "Russian") -- See https://wiki.facepunch.com/gmod/Addon_Localization#supportedlanguages for language ids.

--Help Menu
LANGUAGE.rd_ui_help_menu = "Меню помощи"

LANGUAGE.rd_ui_help_menu_html_code = "<html><body style=\"background-color:DimGray;\">" --DON'T TRANSLATE THAT!


LANGUAGE.rd_ui_help_menu_text = "<p style=\"font-family:tahoma;color:red;font-size:25;text-align:center\"><b>ПРОЧТИТЕ ЭТО!</b></p>" -- Translate text inside <b> </b>
LANGUAGE.rd_ui_help_menu_text2 = "<p style=\"font-family:verdana;color:black;font-size:10px;text-align:left\"><b>Система инвентаря:</b> "
LANGUAGE.rd_ui_help_menu_text3 = "Чтобы переключить инвентарь, нажмите кнопку меню создания (по умолчанию Q). Нажмите на предмет в инвентаре, чтобы взаимодействовать с ним. Чтобы взаимодействовать с выпавшими предметами, нажмите на них клавишу ИСПОЛЬЗОВАТЬ (по умолчанию E).<br><br>"
LANGUAGE.rd_ui_help_menu_text4 = "<b>Покупка предметов:</b> Нажмите F2, чтобы купить и заказать предметы, которые будут доставлены вам по воздуху. Вы можете заказывать предметы только на улице.<br><br>"
LANGUAGE.rd_ui_help_menu_text5 = "<b>Кнопка паники:</b> Нажмите F3, чтобы активировать кнопку паники. Она автоматически обнаружит ваши недуги и попытается вылечить их, используя то, что у вас есть в инвентаре.<br><br>"
LANGUAGE.rd_ui_help_menu_text6 = "<b>Интерфейс:</b> Расположение важных мест и предметов отмечено на вашем экране. Ваши товарищи по команде подсвечиваются через стены, так же как и противоядие."
LANGUAGE.rd_ui_help_menu_text7 = "Если у вас радиационное отравление, в левой нижней части экрана появится значок, указывающий на степень тяжести отравления. Значок также появится, если у вас кровотечение или инфекция.<br><br>"
LANGUAGE.rd_ui_help_menu_text8 = "<b>Эвакуация:</b> На последней минуте раунда на помощь вашему отряду прилетит вертолёт. Бегите в зону эвакуации, отмеченную на вашем экране, чтобы спастись.<br><br>"
LANGUAGE.rd_ui_help_menu_text9 = "<b>Заражение:</b> Обычные зомби заразят вас, когда укусят вас. Чтобы вылечить инфекцию, подойдите к противоядию и нажмите клавишу ИСПОЛЬЗОВАТЬ. Местонахождение противоядия всегда отмечено на вашем экране.<br><br>"
LANGUAGE.rd_ui_help_menu_text10 = "<b>Повелитель зомби:</b> Если игроков больше 8, то будет выбран повелитель зомби. Если повелителю зомби удастся заполнить свой счётчик крови, он переродится в человека и получит специальную награду.<br><br>"
LANGUAGE.rd_ui_help_menu_text11 = "<b>Радиация:</b> Радиация незаметна глазу. Вблизи радиации ваш ручной счётчик Гейгера будет издавать звуки, указывающие на то, насколько близко вы находитесь к радиоактивному месторождению. Радиационное отравление лечится водкой или антирадином.<br><br>"

LANGUAGE.rd_ui_help_menu_button_text = "Чёрт, мне всё равно"
LANGUAGE.rd_ui_help_menu_button_text2 = "Я не читал ничего из этого"
LANGUAGE.rd_ui_help_menu_button_text3 = "Как много слов"
LANGUAGE.rd_ui_help_menu_button_text4 = "Я лучше буду просто ныть о помощи"
LANGUAGE.rd_ui_help_menu_button_text5 = "Просто хочу сыграть"
LANGUAGE.rd_ui_help_menu_button_text6 = "Кому какое дело?"
LANGUAGE.rd_ui_help_menu_button_text7 = "Меню помощи для неудачников"
LANGUAGE.rd_ui_help_menu_button_text8 = "Я думал, что это рп-сервер."
LANGUAGE.rd_ui_help_menu_button_text9 = "Как стрелять в Зоби"
LANGUAGE.rd_ui_help_menu_button_text10 = "Как купить оруж"
LANGUAGE.rd_ui_help_menu_button_text11 = "ЭЙ, РЕБЯТ, ГДЕ АНТИДОТ?"
LANGUAGE.rd_ui_help_menu_button_text12 = "ГДЕ МОЙ ИНВЕНТРЬ"
LANGUAGE.rd_ui_help_menu_button_text13 = "многа букаф"
LANGUAGE.rd_ui_help_menu_button_text14 = "ОТВАЛИТЕ"

--Human Classes
LANGUAGE.rd_human_class_scout = "Разведчик: Имеет лёгкую кевларовую броню, улучшающая его мобильность. Имеет дополнительные кости при старте."
LANGUAGE.rd_human_class_commando = "Коммандос: Имеет прототип кевларовой брони, повышающий его устойчивость к повреждениям."
LANGUAGE.rd_human_class_specialist = "Специалист: Имеет доступ к закрытым предметам и оружию."
LANGUAGE.rd_human_class_engineer = "Техник: Имеет инструменты при старте, необходимые для строительства баррикад."

--HUD
LANGUAGE.rd_hud_bones_x = "%s  КОСТЕЙ"
LANGUAGE.rd_hud_current_ammo_total = "ВСЕГО"
LANGUAGE.rd_hud_current_ammo = "ПАТР"

LANGUAGE.rd_hud_health_x = "Здоровье: %s"

--Deathscreen
LANGUAGE.rd_hud_you_will_respawn_in_x_seconds = "ВЫ ВОЗРОДИТЕСЬ ЧЕРЕЗ %s СЕК."
LANGUAGE.rd_hud_press_any_key_to_respawn = "НАЖМИТЕ ЛЮБУЮ КЛАВИШУ, ЧТОБЫ ВОЗРОДИТЬСЯ"

LANGUAGE.rd_hud_human_death_message_text = "В СЛЕДУЮЩИЙ РАЗ БЕГИТЕ БЫСТРЕЕ"
LANGUAGE.rd_hud_human_death_message2_text = "СМЕРТЬ ЭТО ПОСЛЕДНЕЕ НЕИЗВЕСТНОЕ"
LANGUAGE.rd_hud_human_death_message3_text = "ЖИЗНЬ ЭТО БЛАГО И ЗЛО, А СМЕРТЬ НИ ТО НИ ДРУГОЕ"
LANGUAGE.rd_hud_human_death_message4_text = "У ВСЕГО ЕСТЬ СРОК ГОДНОСТИ"
LANGUAGE.rd_hud_human_death_message5_text = "АРМИЯ ЗОМБИ СТАНОВИТСЯ СИЛЬНЕЕ"
LANGUAGE.rd_hud_human_death_message6_text = "НА ТЕБЕ КРАСНОЕ ПЯТНО"
LANGUAGE.rd_hud_human_death_message7_text = "ТЫ БЫЛ ПРИМАНКОЙ ДЛЯ ЗОМБИ"

LANGUAGE.rd_hud_zombie_death_message_text = "СМЕРТЬ ЭТО ТОЛЬКО НАЧАЛО"
LANGUAGE.rd_hud_zombie_death_message2_text = "ВСТАВАЙ И ПОПЫТАЙСЯ СНОВА"
LANGUAGE.rd_hud_zombie_death_message3_text = "ТЫ ПИЩА ВОРОН"
LANGUAGE.rd_hud_zombie_death_message4_text = "ПОКОЙСЯ С МИРОМ"
LANGUAGE.rd_hud_zombie_death_message5_text = "НИКТО НЕ ЛЮБИТ СМЕРТЬ, НЕ ТАК ЛИ"
LANGUAGE.rd_hud_zombie_death_message6_text = "ЖИЗНЬ ПЕРЕОЦЕНИВАЮТ"
LANGUAGE.rd_hud_zombie_death_message7_text = "ПОКОЙ - ДЛЯ ЖИВЫХ"

LANGUAGE.rd_hud_neutral_death_message_text = "ДЕРЬМО"

--Markers
LANGUAGE.rd_hud_markers_antidote = "ПРОТИВОЯДИЕ"
LANGUAGE.rd_hud_markers_evacuation_zone = "ЗОНА  ЭВАКУАЦИИ"

--Zombie Classes
LANGUAGE.rd_ui_zombie_class_menu = "Меню классов"

LANGUAGE.rd_zombie_class_runner_text = "Бегун: Выносливый и ловкий зомби. Способен заражать людей своими когтями."
LANGUAGE.rd_zombie_class_runner = "Бегун"
LANGUAGE.rd_zombie_class_banshee_text = "Банши: Высокорадиоактивный зомби. Способна дезориентировать людей своим криком."
LANGUAGE.rd_zombie_class_banshee = "Банши"
LANGUAGE.rd_zombie_class_contagion_text = "Заразитель: Раздутый, гноящийся зомби. При убийстве из него вырывается поток кислоты."
LANGUAGE.rd_zombie_class_contagion = "Заразитель"
LANGUAGE.rd_zombie_class_leaper_text = "Прыгун: Костлявый, мутировавший зомби. Способен прыгать на большие расстояния и вызывать кровотечение своими когтями."
LANGUAGE.rd_zombie_class_leaper = "Прыгун"

--Scoreboard
LANGUAGE.rd_teamname_humans = "Отряд 9"
LANGUAGE.rd_teamname_zombies = "Заражённые"
LANGUAGE.rd_teamname_unassigned = "Неназначенные"
LANGUAGE.rd_teamname_spectators = "Наблюдатели"
LANGUAGE.rd_ui_scoreboard_x_team_x_format = "%s ( Игроков: %u%s"
LANGUAGE.rd_ui_scoreboard_one_member = " )"
LANGUAGE.rd_ui_scoreboard_many_members = " )"
LANGUAGE.rd_ui_scoreboard_kills = "Убийств"
LANGUAGE.rd_ui_scoreboard_bones = "Костей"
LANGUAGE.rd_ui_scoreboard_ping = "Пинг"

--Endgame Panel
LANGUAGE.rd_ui_endgame_survivors = "Выжившие"
LANGUAGE.rd_ui_endgame_top_killers = "Лучшие  убийцы"
LANGUAGE.rd_ui_endgame_big_spenders = "Большие  транжиры"

--Endgame Award Names
LANGUAGE.rd_ui_endgame_award_grey_matter_name = "Серое вещество:"
LANGUAGE.rd_ui_endgame_award_silent_partner_name = "Молчаливый партнёр:"
LANGUAGE.rd_ui_endgame_award_longshot_name = "Счастливчик:"
LANGUAGE.rd_ui_endgame_award_big_game_hunter_name = "Заядлый охотник:"
LANGUAGE.rd_ui_endgame_award_bullet_hose_name = "Пулевой шланг:"
LANGUAGE.rd_ui_endgame_award_meat_grinder_name = "Мясорубка:"
LANGUAGE.rd_ui_endgame_award_demolitionist_name = "Подрывник:"
LANGUAGE.rd_ui_endgame_award_firebug_name = "Поджигатель:"
LANGUAGE.rd_ui_endgame_award_kleptomaniac_name = "Клептомания:"
LANGUAGE.rd_ui_endgame_award_broke_the_bank_name = "Сорвал банк:"
LANGUAGE.rd_ui_endgame_award_meet_the_engineer_name = "Познакомьтесь с инженером:"
LANGUAGE.rd_ui_endgame_award_brain_munch_name = "Мозгоед:"
LANGUAGE.rd_ui_endgame_award_get_to_ze_choppa_name = "Все к вертушке:"
LANGUAGE.rd_ui_endgame_award_martyr_name = "Мученик:"
LANGUAGE.rd_ui_endgame_award_unhealthy_glow_name = "Нездоровое свечение:"
LANGUAGE.rd_ui_endgame_award_cum_dumpster_name = "Спермоприёмник:"
LANGUAGE.rd_ui_endgame_award_accident_prone_name = "Невезучий:"
LANGUAGE.rd_ui_endgame_award_roleplayer_name = "РП-игрок:"
LANGUAGE.rd_ui_endgame_award_piss_poor_name = "Нищий:"

--Endgame Award Descriptions
LANGUAGE.rd_ui_endgame_award_grey_matter_desc = "получил наибольшее к-во выстрелов в голову."
LANGUAGE.rd_ui_endgame_award_grey_matter_desc2 = "черепов зомби прострелено"
LANGUAGE.rd_ui_endgame_award_silent_partner_desc = "получил наибольшее к-во помощи в убийстве."
LANGUAGE.rd_ui_endgame_award_silent_partner_desc2 = "помощи в убийстве"
LANGUAGE.rd_ui_endgame_award_longshot_desc = "совершил самое дальнее убийство."
LANGUAGE.rd_ui_endgame_award_longshot_desc2 = "футов"
LANGUAGE.rd_ui_endgame_award_big_game_hunter_desc = "расчленил больше всех зомби с помощью дробовика."
LANGUAGE.rd_ui_endgame_award_big_game_hunter_desc2 = "зомби расчленено"
LANGUAGE.rd_ui_endgame_award_bullet_hose_desc = "использовал больше всего боеприпасов."
LANGUAGE.rd_ui_endgame_award_bullet_hose_desc2 = "выстрелов совершено"
LANGUAGE.rd_ui_endgame_award_meat_grinder_desc = "зарубил больше всех зомби оружием ближнего боя."
LANGUAGE.rd_ui_endgame_award_meat_grinder_desc2 = "убийств в ближнем бою"
LANGUAGE.rd_ui_endgame_award_demolitionist_desc = "убил больше всех зомби с помощью взрывчатки."
LANGUAGE.rd_ui_endgame_award_demolitionist_desc2 = "неопознанных трупов"
LANGUAGE.rd_ui_endgame_award_firebug_desc = "поджёг больше всего зомби."
LANGUAGE.rd_ui_endgame_award_firebug_desc2 = "трупов с хрустящей корочкой"
LANGUAGE.rd_ui_endgame_award_kleptomaniac_desc = "собрал больше всего предметов."
LANGUAGE.rd_ui_endgame_award_kleptomaniac_desc2 = "получено предметов"
LANGUAGE.rd_ui_endgame_award_broke_the_bank_desc = "купил самое дорогое оружие."
LANGUAGE.rd_ui_endgame_award_broke_the_bank_desc2 = "костей потрачено"
LANGUAGE.rd_ui_endgame_award_meet_the_engineer_desc = "построил больше всего баррикад."
LANGUAGE.rd_ui_endgame_award_meet_the_engineer_desc2 = "баррикад было построено"
LANGUAGE.rd_ui_endgame_award_brain_munch_desc = "нанёс наибольший ущерб людям."
LANGUAGE.rd_ui_endgame_award_brain_munch_desc2 = "очков здоровья"
LANGUAGE.rd_ui_endgame_award_get_to_ze_choppa_desc = "первым достиг зоны эвакуации."
LANGUAGE.rd_ui_endgame_award_martyr_desc = "был первым умершим человеком."
LANGUAGE.rd_ui_endgame_award_unhealthy_glow_desc = "получил облучение сильнее всех."
LANGUAGE.rd_ui_endgame_award_unhealthy_glow_desc2 = "злокачественных опухолей"
LANGUAGE.rd_ui_endgame_award_cum_dumpster_desc = "был заражён зомби больше всех."
LANGUAGE.rd_ui_endgame_award_cum_dumpster_desc2 = "заражений"
LANGUAGE.rd_ui_endgame_award_accident_prone_desc = "получил наибольший урон от зомби."
LANGUAGE.rd_ui_endgame_award_accident_prone_desc2 = "урона"
LANGUAGE.rd_ui_endgame_award_roleplayer_desc = "ни черта не сделал."
LANGUAGE.rd_ui_endgame_award_roleplayer_desc2 = "убийств"
LANGUAGE.rd_ui_endgame_award_piss_poor_desc = "потратил меньше всех костей."
LANGUAGE.rd_ui_endgame_award_piss_poor_desc2 = "костей потрачено"

--Shop
LANGUAGE.rd_ui_shop_category_weapons = "Оружие"
LANGUAGE.rd_ui_shop_category_ammo = "Боеприпасы"
LANGUAGE.rd_ui_shop_category_supplies = "Ресурсы"
LANGUAGE.rd_ui_shop_category_misc = "Другое"

LANGUAGE.rd_ui_shop_unknown = "Н/Д"
LANGUAGE.rd_ui_shop_click_an_item = "Нажмите на предмет для просмотра его описания."

LANGUAGE.rd_ui_shop_cost_x = "Цена: %s костей"
LANGUAGE.rd_ui_shop_cost_unknown = "Цена: Н/Д"
LANGUAGE.rd_ui_shop_buy = "Купить"
LANGUAGE.rd_ui_shop_buy_x = "Купить  %s"
LANGUAGE.rd_ui_shop_airdrop_items = "Заказать выбранный груз"

LANGUAGE.rd_ui_shop_cancel = "Закрыть"
LANGUAGE.rd_ui_shop_context_buy_x = "Купить %s"
LANGUAGE.rd_ui_shop_buy_multiple = "Купить несколько"

--Inventory
LANGUAGE.rd_ui_shop_take = "Взять"
LANGUAGE.rd_ui_shop_take_multiple = "Взять несколько"
LANGUAGE.rd_ui_shop_take_x = "Взять %s"
LANGUAGE.rd_ui_shop_take_all = "Взять все"
LANGUAGE.rd_ui_shop_sell = "Продать"
LANGUAGE.rd_ui_shop_sell_multiple = "Продать несколько"
LANGUAGE.rd_ui_shop_sell_x = "Продать %s"
LANGUAGE.rd_ui_shop_sell_all = "Продать все"
LANGUAGE.rd_ui_shop_stash = "Хранить"
LANGUAGE.rd_ui_shop_stash_multiple = "Хранить несколько"
LANGUAGE.rd_ui_shop_stash_x = "Хранить %s"
LANGUAGE.rd_ui_shop_stash_all = "Хранить все"
LANGUAGE.rd_ui_shop_drop = "Выбросить"
LANGUAGE.rd_ui_shop_drop_multiple = "Выбросить несколько"
LANGUAGE.rd_ui_shop_drop_x = "Выбросить %s"
LANGUAGE.rd_ui_shop_drop2_x = "Выбросить  %s"
LANGUAGE.rd_ui_shop_drop_all = "Выбросить все"
LANGUAGE.rd_ui_shop_drop2_all = "Выбросить  все"
LANGUAGE.rd_ui_shop_drop_money = "Бросить"
LANGUAGE.rd_ui_shop_cash_x = "Наличка: $%s"
LANGUAGE.rd_ui_shop_drink = "Выпить"
LANGUAGE.rd_ui_shop_use = "Использовать"
LANGUAGE.rd_ui_shop_eat = "Съесть"
LANGUAGE.rd_ui_shop_inject = "Ввести"
LANGUAGE.rd_ui_shop_throw = "Бросить"

--Regular Items
LANGUAGE.rd_items_energy_drink_name = "Энергетик"
LANGUAGE.rd_items_energy_drink_desc = "Восстанавливает 50 выносливости."
LANGUAGE.rd_items_basic_medkit_name = "Обычная аптечка"
LANGUAGE.rd_items_basic_medkit_desc = "Восстанавливает 50% здоровья."
LANGUAGE.rd_items_advanced_medkit_name = "Расширенная аптечка"
LANGUAGE.rd_items_advanced_medkit_desc = "Восстанавливает 100% здоровья."
LANGUAGE.rd_items_alpha_mutagen_name = "Альфа-мутаген"
LANGUAGE.rd_items_alpha_mutagen_desc = "Прототип препарата, который лечит инфекцию."
LANGUAGE.rd_items_bandage_name = "Бинт"
LANGUAGE.rd_items_bandage_desc = "Останавливает кровотечение."
LANGUAGE.rd_items_cardboard_box_name = "Картонная коробка"
LANGUAGE.rd_items_suitcase_name = "Чемодан"
LANGUAGE.rd_items_briefcase_name = "Кейс"
LANGUAGE.rd_items_wood_name = "Древесина"
LANGUAGE.rd_items_wood_desc = "Используется при строительстве баррикад."
LANGUAGE.rd_items_water_name = "Вода"
LANGUAGE.rd_items_water_desc = "Восстанавливает 25 выносливости и 10 здоровья."
LANGUAGE.rd_items_canned_food_name = "Консервы"
LANGUAGE.rd_items_canned_food_desc = "Восстанавливает 25 здоровья и 10 выносливости."
LANGUAGE.rd_items_wrench_name = "Гаечный ключ"
LANGUAGE.rd_items_wrench_desc = "Зачем вам это есть?"
LANGUAGE.rd_items_unstable_name = "Нестабильный мутаген"
LANGUAGE.rd_items_unstable_desc = "Прототип препарата, который может вылечить инфекцию."
LANGUAGE.rd_items_beer_name = "Пиво"
LANGUAGE.rd_items_beer_desc = "Восстанавливает 15 выносливости."
LANGUAGE.rd_items_tequila_name = "Текила"
LANGUAGE.rd_items_tequila_desc = "Не пейте это дерьмо."
LANGUAGE.rd_items_vodka_name = "Водка"
LANGUAGE.rd_items_vodka_desc = "Снимает радиационное отравление."
LANGUAGE.rd_items_moonshine_vodka_name = "Самогон"
LANGUAGE.rd_items_moonshine_vodka_desc = "Слабая домашняя водка."
LANGUAGE.rd_items_pistol_rounds_name = "Пистолетные патроны"
LANGUAGE.rd_items_pistol_rounds_desc = "40 пистолетных патронов в коробке."
LANGUAGE.rd_items_buckshot_name = "Картечь"
LANGUAGE.rd_items_buckshot_desc = "20 патронов для дробовиков в коробке."
LANGUAGE.rd_items_smg_rounds_name = "Патроны для ПП"
LANGUAGE.rd_items_smg_rounds_desc = "60 патронов для ПП в коробке."
LANGUAGE.rd_items_rifle_rounds_name = "Ружейные патроны"
LANGUAGE.rd_items_rifle_rounds_desc = "60 патронов для авто. винтовки в коробке."
LANGUAGE.rd_items_sniper_rounds_name = "Снайперские патроны"
LANGUAGE.rd_items_sniper_rounds_desc = "30 снайперских патронов в коробке."
LANGUAGE.rd_items_prototype_energy_cell_name = "Прототип энергоблока"
LANGUAGE.rd_items_prototype_energy_cell_desc = "15 энергетических зарядов на блок."
LANGUAGE.rd_items_hammer_name = "Молоток"
LANGUAGE.rd_items_hammer_desc = "Строит баррикады и разбивает черепа."
LANGUAGE.rd_items_axe_name = "Топор"
LANGUAGE.rd_items_axe_desc = "Самое грязное оружие ближнего боя."
LANGUAGE.rd_items_crowbar_name = "Монтировка"
LANGUAGE.rd_items_crowbar_desc = "Выбранное Гордоном оружие."
LANGUAGE.rd_items_fn_fiveseven_name = "FN Five-Seven"
LANGUAGE.rd_items_fn_fiveseven_desc = "Стандартный боевой пистолет."
LANGUAGE.rd_items_usp_compact_name = "USP Compact"
LANGUAGE.rd_items_usp_compact_desc = "Стандартный боевой пистолет."
LANGUAGE.rd_items_p228_compact_name = "P228 Compact"
LANGUAGE.rd_items_p228_compact_desc = "Стандартный боевой пистолет."
LANGUAGE.rd_items_glock_19_name = "Glock 19"
LANGUAGE.rd_items_glock_19_desc = "Стандартный боевой пистолет."
LANGUAGE.rd_items_dual_berettas_name = "Dual Berettas"
LANGUAGE.rd_items_dual_berettas_desc = "По пистолету на каждую руку."
LANGUAGE.rd_items_colt_python_name = "Colt Python"
LANGUAGE.rd_items_colt_python_desc = "Шестизарядный стрелок с кулаком."
LANGUAGE.rd_items_desert_eagle_name = "Desert Eagle"
LANGUAGE.rd_items_desert_eagle_desc = "Что вы комплексуете?"
LANGUAGE.rd_items_mac_10_name = "MAC-10"
LANGUAGE.rd_items_mac_10_desc = "Компактный ПП с умеренной отдачей."
LANGUAGE.rd_items_ump_45_name = "UMP45"
LANGUAGE.rd_items_ump_45_desc = "Мощный ПП с малым магазином."
LANGUAGE.rd_items_cmp_250_name = "CMP250"
LANGUAGE.rd_items_cmp_250_desc = "Прототип ПП, стреляющего очередями."
LANGUAGE.rd_items_winchester_1887_name = "Winchester 1887"
LANGUAGE.rd_items_winchester_1887_desc = "Сейчас сезон зомби."
LANGUAGE.rd_items_tmp_name = "TMP"
LANGUAGE.rd_items_tmp_desc = "Бесшумный, но смертоносный ПП."
LANGUAGE.rd_items_mp5_name = "MP5"
LANGUAGE.rd_items_mp5_desc = "Хорошо сбалансированный, надёжный ПП."
LANGUAGE.rd_items_famas_name = "FAMAS"
LANGUAGE.rd_items_famas_desc = "Самая недорогая штурмовая винтовка."
LANGUAGE.rd_items_fn_p90_name = "FN P90"
LANGUAGE.rd_items_fn_p90_desc = "Мощный ПП с большим магазином."
LANGUAGE.rd_items_steyr_scout_name = "Steyr Scout"
LANGUAGE.rd_items_steyr_scout_desc = "Снайперская винтовка с затвором."
LANGUAGE.rd_items_imi_galil_name = "IMI Galil"
LANGUAGE.rd_items_imi_galil_desc = "Более низкая точность, увеличенный магазин."
LANGUAGE.rd_items_spas_12_name = "SPAS-12"
LANGUAGE.rd_items_spas_12_desc = "Полезно для установления контроля над толпой."
LANGUAGE.rd_items_ak_47_name = "АК-47"
LANGUAGE.rd_items_ak_47_desc = "Хорошо сбалансированная штурмовая винтовка."
LANGUAGE.rd_items_sg_552_name = "SG 552"
LANGUAGE.rd_items_sg_552_desc = "Прилагается бесплатный прицел."
LANGUAGE.rd_items_g3_sg1_name = "G3 SG1"
LANGUAGE.rd_items_g3_sg1_desc = "Автоматическая снайперская винтовка."
LANGUAGE.rd_items_heat_cannon_name = "Пушка ЖАРА"
LANGUAGE.rd_items_heat_cannon_desc = "Экспериментальный выжигатель дальнего действия."
LANGUAGE.rd_items_ppw_952_name = "СОЧ-952"
LANGUAGE.rd_items_ppw_952_desc = "Экспериментальное снарядное оружие частиц."

--Special Items
LANGUAGE.rd_items_anti_rad_name = "Антирадин"
LANGUAGE.rd_items_anti_rad_desc = "Снимает все радиационные отравления."
LANGUAGE.rd_items_respirator_name = "Респиратор"
LANGUAGE.rd_items_respirator_desc = "Фильтрует химикаты и радиацию."
LANGUAGE.rd_items_m1014_name = "M1014"
LANGUAGE.rd_items_m1014_desc = "Превратите всё на своём пути в говяжий фарш."
LANGUAGE.rd_items_m249_name = "M249"
LANGUAGE.rd_items_m249_desc = "Пулемёт поддержки с ленточным магазином."
LANGUAGE.rd_items_awp_name = "AWP"
LANGUAGE.rd_items_awp_desc = "Прекрасный пример высокомощного оружия."
LANGUAGE.rd_items_he_grenade_name = "Осколочная граната"
LANGUAGE.rd_items_he_grenade_desc = "Действие предохранителя составляет 3 секунды."
LANGUAGE.rd_items_incendiary_grenade_name = "Зажигательная граната"
LANGUAGE.rd_items_incendiary_grenade_desc = "Бесплатный зефир в подарок."

--Other Items
LANGUAGE.rd_items_liquid_oxygen_name = "Жидкий кислород"
LANGUAGE.rd_items_liquid_oxygen_desc = "Взрывоопасный жидкий кислород."
LANGUAGE.rd_items_gasoline_name = "Бензин"
LANGUAGE.rd_items_diesel_fuel_name = "Дизельное топливо"
LANGUAGE.rd_items_propane_canister_name = "Канистра с пропаном"
LANGUAGE.rd_items_propane_tank_name = "Баллон с пропаном"
LANGUAGE.rd_items_radioactive_waste_name = "Радиоактивные отходы"
LANGUAGE.rd_items_toxic_waste_name = "Токсичные отходы"

LANGUAGE.rd_items_loot_name = "Выброшенные предметы"
LANGUAGE.rd_items_money_x_bones = "%s костей"
LANGUAGE.rd_items_antidote_crate_name = "Ящик с противоядием"
LANGUAGE.rd_items_supply_crate_name = "Ящик с припасами"
LANGUAGE.rd_items_weapon_cache_name = "Оружейный ящик"
LANGUAGE.rd_items_field_researcher_name = "Учёный"

--Some Admin Help
LANGUAGE.rd_weapon_item_placement_tool_help = "ЛКМ: Разместить энтити          ПКМ: Сменить тип энтити          +ИСПОЛЬЗОВАТЬ: Удалить ближайший энтити текущего типа          ПЕРЕЗАРЯДКА: Удалить все энтити текущего типа"
LANGUAGE.rd_weapon_item_placement_tool_help2 = "ТИП ТЕКУЩЕГО ЭНТИТИ: %s"
LANGUAGE.rd_weapon_prop_placement_tool_help = "ЛКМ: Создать объект          ПКМ: Выбрать модель объекта          +ИСПОЛЬЗОВАТЬ: Удалить ближайший объект          ПЕРЕЗАРЯДКА: Удалите все размещённые объекты"

--Event Notices
LANGUAGE.rd_notices_antidote_shortage_for_x = "Запасы противоядия будут низкими на %s"
LANGUAGE.rd_notices_antidote_shortage_time = "1 мин."
LANGUAGE.rd_notices_antidote_shortage_time2 = "2 мин."
LANGUAGE.rd_notices_antidote_shortage_time3 = "3 мин."
LANGUAGE.rd_notices_antidote_shortage_end = "Дефицит противоядия закончился"

LANGUAGE.rd_notices_nuclear_fallout_coming = "Выпадение ядерных осадков неизбежно"
LANGUAGE.rd_notices_nuclear_fallout_coming_help = "Укройтесь в здании, чтобы избежать радиационного отравления"
LANGUAGE.rd_notices_nuclear_fallout_coming_in_x = "Атмосферные осадки утихнут через %s"
LANGUAGE.rd_notices_nuclear_fallout_time = "30 сек."
LANGUAGE.rd_notices_nuclear_fallout_time2 = "1 мин."
LANGUAGE.rd_notices_nuclear_fallout_end = "Уровень радиоактивности в атмосфере стал безопасным"

LANGUAGE.rd_notices_radio_communications_are_offline_for_x = "Радиосвязь будет отключена в течение %s"
LANGUAGE.rd_notices_radio_communications_are_offline_time = "30 сек."
LANGUAGE.rd_notices_radio_communications_are_offline_time2 = "1 мин."
LANGUAGE.rd_notices_radio_communications_are_offline_time3 = "90 сек."
LANGUAGE.rd_notices_radio_communications_are_online = "Радиосвязь восстановлена"

LANGUAGE.rd_notices_field_researcher_has_been_sighted = "Был обнаружен учёный"

LANGUAGE.rd_notices_keep_an_eye_for_bonus_crate = "Был обнаружен оружейный ящик"

LANGUAGE.rd_notices_the_weather_cinditions_worse = "Погода ухудшается"

--Various Notices
LANGUAGE.rd_notices_picked_up_x = "Получено: %s"
LANGUAGE.rd_notices_x_minutes_unit_evacuation = "%s мин. до эвакуации"
LANGUAGE.rd_notices_undead_onslaught_has_begun = "Нашествие зомби началось"
LANGUAGE.rd_notices_f4_if_you_want_to_be_zombie_lord = "Нажмите F4, если вы хотите стать повелителем зомби"
LANGUAGE.rd_notices_the_evacuation_helicopter_is_en_route = "Эвакуационный вертолёт уже в пути"
LANGUAGE.rd_notices_the_evacuation_helicopter_has_arrived = "Эвакуационный вертолёт прибыл"
LANGUAGE.rd_notices_you_have_45_seconds_to_reach_evacuation_zone = "У вас есть 45 секунд, чтобы добраться до зоны эвакуации"
LANGUAGE.rd_notices_the_location_of_evacuation_zone_has_been_marked = "Месторасположение отмечено на экране"
LANGUAGE.rd_notices_you_cannot_be_the_zombie_lord_now = "Теперь вы не можете быть повелителем зомби"
LANGUAGE.rd_notices_you_have_volunteered_to_be_the_zombie_lord = "Вы вызвались быть повелителем зомби"
LANGUAGE.rd_notices_a_zombie_lord_cannot_be_chosen_at_this_time = "Повелитель зомби не может быть выбран сейчас"
LANGUAGE.rd_notices_you_have_become_the_zombie_lord = "Вы стали повелителем зомби."
LANGUAGE.rd_notices_you_will_become_the_zombie_lord = "Вы станете повелителем зомби"
LANGUAGE.rd_notices_a_zombie_lord_has_been_chosen = "Повелитель зомби был выбран"
LANGUAGE.rd_notices_the_antidote_resupply_location_has_changed = "Место запасов противоядия изменилось"
LANGUAGE.rd_notices_new_undead_mutations_have_been_spotted = "Замечены новые мутации зомби"
LANGUAGE.rd_notices_press_f1_to_view_the_help_menu = "Нажмите F1 для просмотра меню помощи"
LANGUAGE.rd_notices_press_f2_to_buy_items_and_weapons = "Нажмите F2, чтобы купить предметы и оружие"
LANGUAGE.rd_notices_press_f3_to_activate_the_panic_button = "Нажмите F3, чтобы активировать кнопку паники"
LANGUAGE.rd_notices_your_health_has_dropped_below_30 = "Ваше здоровье упало ниже 30%"
LANGUAGE.rd_notices_health_doesnt_regenerate_when_below_30 = "Здоровье не регенерируется, если оно ниже 30%"
LANGUAGE.rd_notices_headshots_combos_earn_you_more_bones = "Комбо из выстрелов в голову приносит вам больше костей"
LANGUAGE.rd_notices_prepare_to_respawn_as_a_human = "Приготовьтесь возродиться в качестве человека"
LANGUAGE.rd_notices_the_undead_have_overwhelmed_x = "Зомби захлестнули %s"
LANGUAGE.rd_notices_x_has_successfully_evacuated = "%s успешно эвакуирован"
LANGUAGE.rd_notices_next_map_x = "Следующая карта: %s"
LANGUAGE.rd_notices_helicopter_left_without_you = "Эвакуационный вертолёт улетел без вас"
LANGUAGE.rd_notices_you_cannot_use_your_radio_indoors = "Вы не можете использовать радио в помещении"
LANGUAGE.rd_notices_radio_communications_are_offline = "Радиосвязь не работает"
LANGUAGE.rd_notices_panic_button_detected_that_you_were_x = "Кнопка паники обнаружила, что у вас %s"
LANGUAGE.rd_notices_panic_block_status1 = "кровотечение"
LANGUAGE.rd_notices_panic_block_status2 = "облучение"
LANGUAGE.rd_notices_panic_block_status3 = "тяжёлые ранения"
LANGUAGE.rd_notices_panic_block_status4 = "лёгкие ранения"
LANGUAGE.rd_notices_panic_block_status5 = "усталость"
LANGUAGE.rd_notices_panic_block_status6 = "усталость"
LANGUAGE.rd_notices_panic_button_did_not_detect_items = "Кнопка паники не обнаружила никаких полезных предметов"
LANGUAGE.rd_notices_plus15_health = "+15 здоровья"
LANGUAGE.rd_notices_plus25_stamina = "+25 выносливости"
LANGUAGE.rd_notices_plus25_health = "+25 здоровья"
LANGUAGE.rd_notices_plus15_stamina = "+15 выносливости"
LANGUAGE.rd_notices_plus20_stamina = "+20 выносливости"
LANGUAGE.rd_notices_minus2_radiation = "-2 радиации"
LANGUAGE.rd_notices_plus4_intoxication = "+4 опьянения"
LANGUAGE.rd_notices_minus1_radiation = "-1 радиации"
LANGUAGE.rd_notices_plus6_intoxication = "+6 опьянения"
LANGUAGE.rd_notices_plus2_intoxication = "+2 опьянения"
LANGUAGE.rd_notices_plus15_intoxication = "+15 опьянения"
LANGUAGE.rd_notices_you_feel_extremely_nauseous = "Вас сильно тошнит"
LANGUAGE.rd_notices_plus_x_radiation = "+%s радиации"
LANGUAGE.rd_notices_minus_x_radiation = "-%s радиации"
LANGUAGE.rd_notices_your_infection_has_been_cured = "Ваша инфекция была вылечена"
LANGUAGE.rd_notices_you_were_infected_by_the_drug = "Вы заразились от наркотика"
LANGUAGE.rd_notices_you_feel_exhausted = "Вы чувствуете усталость"
LANGUAGE.rd_notices_your_whole_body_aches = "У вас болит всё тело"
LANGUAGE.rd_notices_you_feel_a_sharp_pain_in_your_chest = "Вы чувствуете резкую боль в груди"
LANGUAGE.rd_notices_your_legs_begin_to_feel_weak = "Ваши ноги начинают слабеть"
LANGUAGE.rd_notices_your_legs_start_to_feel_better = "Ваши ноги начинают чувствовать себя лучше"
LANGUAGE.rd_notices_minus20_health = "-20 здоровья"
LANGUAGE.rd_notices_you_just_ate_a_fucking_wrench = "Вы только что съели грёбаный гаечный ключ."
LANGUAGE.rd_notices_you_found_some_bones = "Вы нашли несколько костей"
LANGUAGE.rd_notices_minus5_radiation = "-5 радиации"
LANGUAGE.rd_notices_plus50_stamina = "+50 выносливости"
LANGUAGE.rd_notices_plus75_health = "+75 здоровья"
LANGUAGE.rd_notices_plus150_health = "+150 здоровья"
LANGUAGE.rd_notices_plus20_health = "+20 здоровья"
LANGUAGE.rd_notices_stopped_bleeding = "Остановка кровотечения"
LANGUAGE.rd_notices_plus_x_bones = "+%s костей"
LANGUAGE.rd_notices_plus_x_bone = "+%s кость"
LANGUAGE.rd_notices_x_headshot_combo = "Комбо: %s выстрелов в голову"
LANGUAGE.rd_notices_you_have_been_irradiated = "Вы были облучены"
LANGUAGE.rd_notices_radiation_sickness_will_fade = "Лучевая болезнь со временем проходит"
LANGUAGE.rd_notices_you_have_been_infected = "Вы были инфицированы"
LANGUAGE.rd_notices_you_can_cure_your_infection_with_the_antidote = "Вы можете вылечить свою инфекцию с помощью противоядия"
LANGUAGE.rd_notices_the_antidote_location_is_marked_on_your_screen = "Местонахождение противоядия отмечено на вашем экране"
LANGUAGE.rd_notices_you_are_bleeding_to_death = "Вы истекаете кровью до смерти"
LANGUAGE.rd_notices_you_can_cover_wounds_with_bandages = "Раны можно перевязать бинтами"
LANGUAGE.rd_notices_you_have_redeemed_yourself = "Вы возродили себя"
LANGUAGE.rd_notices_you_will_respawn_as_a_human = "Вы возродитесь в качестве человека"
LANGUAGE.rd_notices_plus_x_blood = "+%s КРОВИ"
LANGUAGE.rd_notices_harm_the_humans_to_fill_blood_meter = "Наносите вред людям, чтобы наполнить свой счётчик крови"
LANGUAGE.rd_notices_once_meter_filled_you_will_be_redeem = "Как только ваш счётчик заполнится, вы будете возрождены"
LANGUAGE.rd_notices_killing_a_human_will_fill_meter = "Убийство человека быстрее заполнит ваш счётчик"
LANGUAGE.rd_notices_you_can_choose_your_class = "Вы можете выбрать класс зомби, нажав F2"
LANGUAGE.rd_notices_the_infection_slows_your_stamina_regeneration = "Инфекция замедляет регенерацию вашей выносливости"
LANGUAGE.rd_notices_your_stamina_has_dropped_below_30percent = "Ваша выносливость упала ниже 30%"
LANGUAGE.rd_notices_stamina_replenishes_slower_when_below_30percent = "Выносливость восполняется медленнее, если её уровень ниже 30%"
LANGUAGE.rd_notices_you_havent_ordered_any_shipments = "Вы не заказывали никаких товаров"
LANGUAGE.rd_notices_you_cant_order_shipments_while_indoors = "Вы не можете заказывать предметы, находясь в помещении"
LANGUAGE.rd_notices_your_shipment_is_due_in_x_sec = "Ваш груз должен быть отправлен через %s сек."
LANGUAGE.rd_notices_your_shipment_has_been_airdropped = "Ваш груз был доставлен"
LANGUAGE.rd_notices_you_were_successfully_evacuated = "Вы были успешно эвакуированы"
LANGUAGE.rd_notices_you_infected_a_human = "Вы заразили человека"
LANGUAGE.rd_notices_a_radioactive_zombie_is_nearby = "Поблизости находится радиоактивный зомби"
LANGUAGE.rd_notices_radioactive_zombies_will_poison_you = "Радиоактивные зомби отравляют находящихся рядом людей"
LANGUAGE.rd_notices_you_made_it_to_heli = "Вы добрались до зоны эвакуации"
LANGUAGE.rd_notices_heli_will_take_off_shortly = "Вертолёт скоро взлетит"
LANGUAGE.rd_notices_a_radioactive_deposit_is_nearby = "Поблизости находится радиоактивное месторождение"
LANGUAGE.rd_notices_toggle_build_mode_reload_key = "Переключение режима строительства с помощью клавиши перезарядки"
LANGUAGE.rd_notices_rotate_barricade_by_rmb_key = "Поверните баррикаду, щёлкнув правой кнопкой мыши"
LANGUAGE.rd_notices_you_dont_have_enough_wood = "У вас недостаточно дерева"
LANGUAGE.rd_notices_built_a_barricade_1_piece_of_wood = "Постройка баррикады, используя 1 кусок дерева"
LANGUAGE.rd_notices_you_can_also_repair_door = "Вы также можете отремонтировать двери"
LANGUAGE.rd_notices_fortified_a_door_using_1_piece_of_wood = "Укрепление двери с помощью 1 куска дерева"
LANGUAGE.rd_notices_you_cant_build_a_barricade_here = "Здесь нельзя построить баррикаду"
LANGUAGE.rd_notices_rmb_to_scroll_through_your_inventory = "Щёлкните правой кнопкой мыши для прокрутки инвентаря"
LANGUAGE.rd_notices_lmb_to_select_an_item_and_use_it = "Щёлкните левой кнопкой мыши, чтобы выбрать элемент и использовать его"
LANGUAGE.rd_notices_rmb_to_use_your_screaming_ability = "Щёлкните правой кнопкой мыши, чтобы использовать свою способность крика"
LANGUAGE.rd_notices_your_scream_will_disorent_nearby_people = "Ваш крик дезориентирует находящихся рядом людей"
LANGUAGE.rd_notices_you_disorented_a_human = "Вы дезориентировали человека"
LANGUAGE.rd_notices_you_irradiated_a_human = "Вы облучили человека"
LANGUAGE.rd_notices_hit_people_to_infect_them = "Атакуйте людей, чтобы заразить их"
LANGUAGE.rd_notices_you_will_unleash_a_toxic_shower_when_you_die = "После смерти вы выпустите всплеск токсинов"
LANGUAGE.rd_notices_your_attacks_cause_bleeding = "Ваши атаки вызывают кровотечение"
LANGUAGE.rd_notices_you_made_a_human_bleed = "Вы вызываете у людей кровотечение"
LANGUAGE.rd_notices_heli_left_evac_zone = "Вертолёт покинул зону эвакуации"
