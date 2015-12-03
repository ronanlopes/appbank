class Movimentacao < ActiveRecord::Base

  belongs_to :tipo_movimentacao
  belongs_to :conta_origem, class_name: 'Conta'
  belongs_to :conta_destino, class_name: 'Conta'

  validates :tipo_movimentacao_id, presence: true

end
