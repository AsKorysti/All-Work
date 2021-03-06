﻿&НаКлиенте
Процедура ДобавитьВсех()
	ТаблицаАгентов.Очистить();
	ДобавитьВсехМаршруты();
КонецПроцедуры
Процедура ДобавитьВсехМаршруты()
	МТ_Агенты = Справочники.ФизическиеЛица.Выбрать();
	МаршрутыАгентов = Справочники.МТ_МаршрутыАгентов.Выбрать(); 
	Пока МТ_Агенты.Следующий() Цикл
		Пока МаршрутыАгентов.Следующий() Цикл
			Если НЕ (МТ_Агенты.ПометкаУдаления = Истина) И (МаршрутыАгентов.Агент.Код = МТ_Агенты.Код) Тогда
			    Сообщить("1");	
				НоваяСтрока = ТаблицаАгентов.Добавить();
				НоваяСтрока.Код = Число(МТ_Агенты.Код);
				НоваяСтрока.Агент = МТ_Агенты.Ссылка;
				Прервать;
				//НоваяСтрока.КПККод = Число(МТ_Агенты.Код);	
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;  	
КонецПроцедуры
Процедура Добавить()
	СпрАгенты = Справочники.МТ_Маршруты.ПолучитьФормуВыбора(,ЭтаФорма);
	СпрАгенты.ЗакрыватьПриВыборе = Ложь;
	СпрАгенты.ОткрытьМодально();
КонецПроцедуры
Процедура ОбработкаВыбора(ЗначениеВыбора, Источник)
	флаг = 0;
	Если ЗначениеВыбора.ПометкаУдаления = Истина Тогда
		Сообщить("Нельзя выбирать элемент помеченый на удаление!");
		флаг = 1;
	ИначеЕсли ЗначениеВыбора.Этогруппа Тогда
		Сообщить("Это группа!");
		флаг = 1;
	КонецЕсли;
	Если НЕ(СтрДлина(Строка(ТаблицаМаршрутов.Найти(ЗначениеВыбора.ССылка))) = 0) Тогда
		Сообщить("Агент уже в списке на выгрузку");
		флаг = 1;
	КонецЕсли;
	Если флаг = 0 Тогда
		НоваяСтрока = ТаблицаАгентов.Добавить();
		НоваяСтрока.Агент = ЗначениеВыбора.Агент.Ссылка;
		НоваяСтрока.Код = ЗначениеВыбора.Ссылка;
		//НоваяСтрока.КПККод = ЗначениеВыбора.Код;
	КонецЕсли;
КонецПроцедуры
Процедура Удалить()
	Попытка
		нСтр = ТаблицаАгентов.Найти(ЭлементыФормы.ТабличноеПоле1.ТекущиеДанные.Агент, "Агент");
		ТаблицаАгентов.Удалить(нСтр);	
	Исключение
	КонецПопытки;
КонецПроцедуры
Процедура УдалитьВсех()
		ТаблицаАгентов.Очистить();
КонецПроцедуры
Процедура КнопкаВыполнитьНажатие(Кнопка)
	ВыполнитьМодуль(ТаблицаАгентов.ВыгрузитьКолонку("Агент"),0);
КонецПроцедуры
Процедура ИзменитьПуть(Элемент)
	//Справочники.ИдентификаторыОбъектовМетаданных.ОбновитьДанныеСправочника();
	ФК = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ФК.Каталог = СокрЛП(МТ_ПутьКФайлам);
	Если ФК.Выбрать() Тогда
		ПутьКФайлам = ФК.Каталог + "\";
		Константы.МТ_ПутьКФайлам.Установить(МТ_ПутьКФайлам);
	КонецЕсли;
КонецПроцедуры
Процедура ПриОткрытии()
	ДатаФорм = ТекущаяДата();
	МТ_ПутьКФайлам = СокрЛП(Константы.МТ_ПутьКФайлам.Получить());
	флагОбмена = 0;
	Если (СокрЛП(ПараметрЗапуска) = "uploadAll") И (флагОбмена = 0) Тогда
		ДобавитьВсех();
		КнопкаВыполнитьНажатие(1);
		ЗавершитьРаботуСистемы(Ложь);
	Иначе	
		ДобавитьВсех();
	КонецЕсли;
КонецПроцедуры