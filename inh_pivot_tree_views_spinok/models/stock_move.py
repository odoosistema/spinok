from odoo import _, api, fields, models


class StockMove(models.Model):
    _inherit = 'stock.move'

    barcode = fields.Char(string='Codigo de barra',
                          related="product_id.barcode")
    stock_ubication = fields.Char(string='Ubicacion en Bodega',
                          related='product_id.stock_ubication')


