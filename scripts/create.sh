#!/bin/bash
PASSWORD="password"
HOST="127.0.0.1"
PORT="3306"
USER="root"


run_sql(){
	if [ ! -z "$2" ]
	then
	    database=$1
		sql=$2
		result=$(mysql -h $HOST -P $PORT -u $USER --password=$PASSWORD -e "$sql" $database)
    else
		sql=$1
        result=$(mysql -h $HOST -P $PORT -u $USER --password=$PASSWORD -e "$sql")
	fi
	echo $result
}
    

ans=$(run_sql 'SHOW DATABASES')
echo $ans
echo '==='
echo "$(echo $ans | grep chiquito)"
if [ ! -z "$(echo $ans | grep chiquito)" ]
then
	run_sql 'DROP DATABASE chiquito'
fi
run_sql 'CREATE DATABASE chiquito'
mysql -h $HOST -P $PORT -u $USER --password=$PASSWORD chiquito <<EOF
DROP TABLE IF EXISTS JOKES;
CREATE TABLE IF NOT EXISTS JOKES(
ID INTEGER NOT NULL AUTO_INCREMENT,
AUTHOR VARCHAR(30),
VALUE VARCHAR(1024),
CREATED_AT BIGINT,
UPDATED_AT BIGINT,
PRIMARY KEY(ID));
EOF
run_sql "chiquito" "SHOW TABLES"
echo $result
mysql -h $HOST -P $PORT -u $USER --password=$PASSWORD chiquito < frases.sql
run_sql "chiquito" "SELECT * FROM JOKES"
echo $result
