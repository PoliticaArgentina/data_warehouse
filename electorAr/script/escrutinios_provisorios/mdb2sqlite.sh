#!/bin/bash
# Inspired by 
# https://www.codeenigma.com/community/blog/using-mdbtools-nix-convert-microsoft-access-mysql

# USO: EJEMPLO PARA BASE .mdb DE RESUTLADOS ELECCIONES ARGENTINA 2003 en Atlas de Andy Tow https://www.andytow.com/atlas/totalpais/downloads.html

# Correr el siguiente comando:  ./mdb2sqlite.sh Argentina03.mdb
# Esperar... y esperar un rato más... y un poco más... 

mdb-schema Argentina03.mdb sqlite > schema.sql
mkdir sqlite
mkdir sql
for i in $( mdb-tables Argentina03.mdb ); do echo $i ; mdb-export -D "%Y-%m-%d %H:%M:%S" -H -I sqlite migration-export.mdb $i > sql/$i.sql; done

mv schema.sql sqlite
mv sql sqlite
cd sqlite

cat schema.sql | sqlite3 db.sqlite3

for f in sql/* ; do echo $f && (echo 'BEGIN;'; cat $f; echo 'COMMIT;') | sqlite3 db.sqlite3; done
