#!/bin/sh
mysql -uroot -e 'DROP DATABASE IF EXISTS intern_diary_mrk1869_test'
mysql -uroot -e 'CREATE DATABASE intern_diary_mrk1869_test'
mysql -uroot intern_diary_mrk1869_test < ../db/schema.sql
