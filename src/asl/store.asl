// 1. База начальных убеждений
mealsInStore(6). // Начальное количество порций в хранилище.
// 2. Планы по достижению целей (табл. 8)
@st1
+!moreMeal(X)[source (Seller)]:
    mealsInStore(MIS) & MIS>=X<-
    -+mealsInStore(MIS-X);
    .print("  There are ", MIS-X, " meals in storage");
    .wait(1000);
    .send(Seller, achieve, takeMeal(X)).  
/*План моделирует выдачу продавцу со склада порции еды размером X, если получен
соответствующий запрос и на складе есть еда в достаточном количестве.
*/

@st2
+!moreMeal(X)[source (Seller)]: 
	mealsInStore(MIS) & MIS<X<-
	.wait(1000);
	!moreMeal(X)[source (Seller)]. 
/*Если в настоящее время на складе нет еды, то обработка запроса откладывается на
некоторое время, в течение которого, скорее всего, еда на складе появится.
План рекурсивный. 
Обратите внимание, что при рекурсивном вызове в аннотации сохраняется
имя продавца (строка 19), приславшего изначальный запрос. Если аннотацию убрать, то на
очередной итерации имя продавца потеряется и источником цели «!moreMeal(X)» будет сам
склад, что приведет к ошибкам.
*/

@st3
+!takeNewMeal <-
	?mealsInStore(MIS);
	-+mealsInStore(MIS+1).
/*План моделирует получение порции еды от повара.
*/

@st4
+!who_is_last<-true.
/*План «заглушка», обеспечивающий нейтральную реакцию склада при получении цели
«who_is_last», поступающей всем агентам при создании очередного клиента.
*/