**Email subscribe application**

Задачи приложения:
1 показывать пользователю форму для ввода и оправки email адреса
2 принимать и сохранять email адреса

Пишите свой код только в местах YOUR CODE HERE.
При успешном выполнении задания все тесты должны проходить.

Подготовка среды разработки:

Сделайте Fork проекта.
Клонируйте проект.

`bundle install`

Команды:

`rackup  # старт сервера`

`ruby test/run_all.rb -v  # запуск всех тестов`

`ruby test/application_test.rb -v  # запуск только тестов из файла application_test.rb`

**Задача 1**

Добавить форму для отправки email на сервер по адресу POST /emails

Код писать в `app/views/pages/root.html:13`

`ruby test/system/root_page_test.rb -v  # тесты задания`


**Задача 2**

Реализовать модель Email, которая будет принимать email адрес, валидировать его и сохранять в базе если адрес валидный

Код писать в `app/models/email.rb:3`

`ruby test/models/email_test.rb -v  # тесты задания`

**Задача 3**

Реализовать прием и обработку email адресов пользователей

Код писать в `app/application.rb:13` и `app/controllers/emails_controller.rb:5`

`ruby test/system/emails_test.rb -v  # тесты задания`

**Задача 4**

Сделайте pull request в этот репозиторий из своего.

