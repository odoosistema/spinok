# -*- coding: utf-8 -*-
# Copyright (C) Softhealer Technologies.
{
    'name': 'Inherit views pivot tree spinok',
    'version': '14',
    'license': 'LGPL-3',
    'summary': 'Modulo para añadir campo codigo de barra en el modelo stock en las vistas pivot y tree',
    'category': '',
    'author': 'LAngel Cartaya',
    'depends': ['base', 'stock', 'sale', 'product_multiple_barcodes','inh_product_spinok'],
    'data': [
        'views/stock_quant_inh_view.xml','views/purchase_order_inh_view.xml',
    ],
    'installable': True,
}
