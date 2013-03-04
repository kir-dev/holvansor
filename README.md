Holvansör?
==========

Ez egy egyszerű alkalmazás, amivel gyorsan kiderítheted hol van a sör a házban (sch).

Futtatás
--------

Szerezz kódot:

~~~
$ git clone git://github.com/tmichel/holvansor.git
~~~

In-memory adatbázissal:

~~~
$ cd /path/to/holvasor
$ ruby app/app.rb
~~~

Perzisztens SQLite adatbázissal

~~~
$ cd /path/to/holvasor
$ DATABASE_URI="/path/to/db.sqlite3" ruby app/app.rb
~~~