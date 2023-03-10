
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Сообщить(ТекущаяДатаСеанса());
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Объект.ПериодНачало = НачалоДня(ТекущаяДата());
	Объект.ПериодОкончание = КонецДня(ТекущаяДата());
	
	//Режим = РежимДиалогаВопрос.ДаНет;
	//Текст = "Предварительно загрузить Контакную информацию клиентов?";
	//Ответ = Вопрос(Текст, Режим, 0);
	//Если Ответ = КодВозвратаДиалога.Да Тогда
	//	ЗагрузитьКонтактнуюИнформациюКлиентовНаСервере();	
	//КонецЕсли; 	                                                               
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьЗагрузку(Команда)
	ВыполнитьЗагрузкуНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьКонтактнуюИнформациюКлиентовНаСервере()	
	АдресМВТ = ПоместитьВоВременноеХранилище(УправлениеЗаявкамиНаЗвонок.ПодготовитьТаблицуКлиентов());		
КонецПроцедуры

&НаСервере
Процедура ВыполнитьЗагрузкуНаСервере()
	
	ПараметрыСайтов = УправлениеОбращениямиCoMagic.ПолучитьПараметрыПодключенияComagic(Объект.Сайты.Выгрузить().ВыгрузитьКолонку("Сайт"));
	Если НЕ ПараметрыСайтов = Неопределено И ПараметрыСайтов.Количество() Тогда		
		Если ЭтоАдресВременногоХранилища(АдресМВТ) Тогда
			НайденыеКлиенты_МВТ = ПолучитьИзВременногоХранилища(АдресМВТ);		
		Иначе
			НайденыеКлиенты_МВТ = Неопределено;	
		КонецЕсли;
		ПараметрыЗадания = Новый Массив;
		ПараметрыЗадания.Добавить(Объект.ПериодНачало);
		ПараметрыЗадания.Добавить(Объект.ПериодОкончание);
		ПараметрыЗадания.Добавить(ПараметрыСайтов);
		ПараметрыЗадания.Добавить(НайденыеКлиенты_МВТ);
		ПараметрыЗадания.Добавить(ЗагрузкаПоДням);
		Ключ = "УправляемаяЗагрузкаДанныхCoMagic_" + ТекущаяДата();//Строка(Новый УникальныйИдентификатор);
		Сообщить("Старт задания: " + Ключ);
		
		УправлениеОбращениямиCoMagic.УправляемаяЗагрузкаДанныхCoMagic(Объект.ПериодНачало, Объект.ПериодОкончание,
			ПараметрыСайтов, НайденыеКлиенты_МВТ, ЗагрузкаПоДням); 	
		
		//ФоновыеЗадания.Выполнить("УправлениеОбращениямиCoMagic.УправляемаяЗагрузкаДанныхCoMagic", ПараметрыЗадания, Ключ, "УправляемаяЗагрузкаДанныхCoMagic"); 		
	КонецЕсли; 	
	
КонецПроцедуры
