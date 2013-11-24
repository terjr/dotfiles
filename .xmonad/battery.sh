#!/bin/bash

echo Batt: $(acpi -b | awk '{print $4}' | tr -d ,)
