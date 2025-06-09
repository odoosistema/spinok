#!/bin/bash
requirements_path="/mnt/extra-addons/Addval-Connect/odoo-addval-modules/requirements.txt"
if [ -e $requirements_path ]; then
    echo "Installing requirements..."
    pip install -r $requirements_path --break-system-packages
fi
