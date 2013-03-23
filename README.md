Holvansör?
==========

Ez egy egyszerű alkalmazás, amivel gyorsan kiderítheted hol van a sör a házban (sch).

Futtatás fejlesztéskor
----------------------

Szerezz kódot:

~~~
$ git clone git://github.com/kir-dev/holvansor.git
~~~

Szerezz gemeket:

~~~
$ bundle install
~~~

Az alkalmazás indítása:

~~~
$ cd /path/to/holvasor
$ rackup
~~~

Alapértelmezetten a projekt gyökérkönyvtárába `dev.sqlite3` teszi az adatbázist.

Az adatbázis uri-ja felülírható, ha megadjuk a DATABASE_URI változót.

~~~
$ cd /path/to/holvasor
$ DATABASE_URI=sqlite://path/to/db.slite3 rackup
~~~

Konfiguráció
------------

A `config/config.yml` fájlban találhatóak az alkalmazáshoz kapcsolódó konfigurációs
lehetőségek.

- *db_uri*: az adatbázis urija olyan formában, amit a `sequel` gem elfogad. 

    Bővebb információ a következő [linken](http://sequel.rubyforge.org/rdoc/files/doc/opening_databases_rdoc.html).

- *host*: a domain, ami alatt az alaklmazás fut    

Az email küldéshez szükséges konfiguráció a `config/mail.yml` fájlban található.
A konfigurációs lehetőségekről bővebben a [itt](https://github.com/benprew/pony/blob/master/README.rdoc)
találsz leírást.

A jelenlegi konfiguráció működőképes a stewie-n.

Deploy
------

**TODO**

1. Az előző pontban tárgyalt konfigurációs beállításokat ellenőrizzük!
2. A `clean_rooms` rake taskra állítsunk be egy cronjobot.