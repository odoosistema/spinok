from odoo import _, api, fields, models


class StockValuationLayer(models.Model):
    _inherit = 'stock.valuation.layer'

    barcode = fields.Char(string='Codigo de barra',
                          related='product_id.barcode')
    stock_ubication = fields.Char(string='Ubicacion en Bodega',
                          related='product_id.stock_ubication')

