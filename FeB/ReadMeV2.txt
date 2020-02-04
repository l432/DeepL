1. Вибрати (за необхідності) папки, де розміщена програма SCAPS ("SCAPS Folder") та  будуть зберігатися результати ("Results Folder") 


Для кожної товщини бази та концентрації бору в базі:

2.Встановлюємо значення товщини бази та концентрації бору в базі

3. Кнопка ".scaps file create" - створюємо settings-файли 
  "FeD*.scaps" для розрахунку ВАХ при наявності лише міжвузольного заліза
  "D1Т*.scaps" для розрохунку розподілу дефектів по товщині
  "FeBD*.scaps" для розрахунку ВАХ при пар залізо-бор та міжвузольного заліза

Для кожної температури

4. В SCAPS завантажуємо файл "FeD*.scaps",
    натискаємо "Clear all simulation",
    запускаємо "Calculate: batch",
    зберігаємо *.iv файл.

5."Витягуємо" ВАХ (кнопки "Select .iv file" та "Extract IV files")

6.В SCAPS завантажуємо файл "D1Т*.scaps",
    натискаємо "Clear all simulation",
    запускаємо "Calculate: single shot",
    зберігаємо *.eb файл.

7. Створюємо файли розподілу дефектів по товщині - кнопка "Fe(x) and FeB(x) create".

8. В SCAPS завантажуємо файл "FeBD*.scaps",
    натискаємо "Clear all simulation",
    запускаємо "Calculate: batch",
    зберігаємо *.iv файл.

9."Витягуємо" ВАХ (кнопки "Select .iv file" та "Extract IV files")

Для кожної папки з файлами ("Fe" та "FeB")

10. Визначаємо параметри ВАХ:
   запускаємо програму Shottky.exe
   вибираємо папку з файлами (кнопка "Сhose directory" на вкладці "Directory operation")
   вибираємо функцію D-diod (кнопка "Select")
   встановлюємо наступні параметри (кнопка "Option")
     * "Iteration Number" - 3000
     *  "Evolution Type" - MABC
     *  n1 - Constant, 1     
     *  Rs -  Constant, 0
     *  Io1 - Logarithmic, Initial 1e-13, 1e-10;  Limit 1e-28, 1e-8
     *  Rsh - Constant, 1e20
     *  n2 - Normal, Initial 1, 1.5;  Limit 1, 2.5
     *  Io2 - Logarithmic, Initial 1e-9, 1e-5;  Limit 1e-18, 1e-5
     *  Evolution  Algoritm, Xmin = 0, Xmax = 0.4, Ymin =0, Ymax = No
   запускаємо розрахунок (кнопка "Create dates.dat") 

11. Зводимо результати: кнопка "dates.dat convert" і вибираємо створені у попередньому пункті dates.dat.


