#!/bin/bash

# CHANGE THIS VALUES TO YOURS THIS ARE MY OWN
lmax="1346"
lmin="674"
rmax="1332"
rmin="618"

# Exec binary and put the values automatically
echo -e "$lmax\n$lmin\n$rmax\n$rmin\n" | (
    /home/deck/overwrite_trigger_cal
)

echo "Process completed."