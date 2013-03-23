Holvansör?
==========

Ez egy egyszerű alkalmazás, amivel gyorsan kiderítheted hol van a sör a házban (sch).

Futtatás
--------

Szerezz kódot:

~~~
$ git clone git://github.com/tmichel/holvansor.git
~~~

Szerezz gemeket:

~~~
$ bundle install
~~~

In-memory adatbázissal:

~~~
$ cd /path/to/holvasor
$ rackup
~~~

Perzisztens SQLite adatbázissal

~~~
$ cd /path/to/holvasor
$ DATABASE_URI="/path/to/db.sqlite3" rackup
~~~
