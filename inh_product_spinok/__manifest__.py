{
    'name': 'Modificacion de producto ',
    'category': 'stock',
    'license': 'LGPL-3',
    'depends': ['product', 'contacts', 'account', 'stock'],
    'data': [
       'views/product_template_view.xml',
       'views/stock_picking_view.xml',
       'views/res_partner_view.xml'
    ],
    'installable': True,
    'application': True,
}
