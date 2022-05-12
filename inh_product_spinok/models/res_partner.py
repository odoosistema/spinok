# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.
from odoo import api, fields, models

class InhResPartner(models.Model):
    _inherit = 'res.partner'


    is_technical = fields.Boolean('Es tecnico?', default=False)
    location_id = fields.Many2one('stock.location','Ubicacion de BM')
