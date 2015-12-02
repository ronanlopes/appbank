class Movimentacao < ActiveRecord::Base

  belongs_to :tipo_movimentacao
  belongs_to :conta_origem, class_name: 'Conta'
  belongs_to :conta_destino, class_name: 'Conta'

end
