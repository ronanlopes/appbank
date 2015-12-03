class TipoMovimentacao < ActiveRecord::Base

  has_many :movimentacao

  def self.get_id_by_nome(nome)
    TipoMovimentacao.find_by_nome(nome).id
  end

end
