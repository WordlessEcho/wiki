#!/bin/bash

sed -i 's/^---$/+++/g;
s/^title: /title = "/g;
/^title/ s/$/"/;

s/^description: /description = "/g;
/^description/ s/$/"/;

/^published.*/d;

s/^date: /date = /g;

s/^tags: /tags = "/g;
/^tags/ s/$/"/;

/^editor:/d' $1
