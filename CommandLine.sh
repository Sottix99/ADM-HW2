#!/bin/bash

echo "A script to find out the first 10 profiles who have published a post with a description longer than 100 characters"

echo "Downloading instagram_posts.zip";
wget https://adm2022.s3.amazonaws.com/instagram_posts.zip;
echo "Done";

echo "Unzipping instagram_posts.zip";
unzip instagram_posts.zip;
echo "Done";

echo "Creating a reduced version called reduced_posts.csv";
cut -f 3,4,8 instagram_posts.csv | tr '\t' ',' > reduced_posts.csv;
echo "Done";

echo "We take a look to the first 10 lines of reduced_posts.csv";
head -10 reduced_posts.csv;

echo "We perform the required task...";
awk -F',' -vOFS=',' '{if (length($3) > 100) print $1, $2, length($3)}' reduced_posts.csv | sort -t$',' -k3 -n | head -10 > results.csv;
echo "Done";
rm reduced_posts.csv

echo "Here are the results, the desired profiles are:";
awk -F',' -vOFS=',' '{if (length($2) == 0) print "User was not found!"; else print $2}' results.csv;