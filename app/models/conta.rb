class Conta < ActiveRecord::Base

  belongs_to :user
  has_many :movimentacoes_origem, :class_name => 'Movimentacao', :foreign_key => :conta_origem_id
  has_many :movimentacoes_destino, :class_name => 'Movimentacao', :foreign_key => :conta_destino_id  

  #Verificar i18n
  validates :saldo, :numericality => { :greater_than_or_equal_to => 0 }

  def saldo_to_s
    "R$ #{self.saldo/100}"
  end

  def movimentacoes
    movimentacoes_origem + movimentacoes_destino
  end

  def deposito(valor)
    Conta.transaction do
      self.saldo += valor
      self.save!
      movimentacao = Movimentacao.new(conta_origem_id: self.id, conta_destino_id: self.id, valor: valor, tipo_movimentacao_id: TipoMovimentacao.get_id_by_nome("Depósito"))
      movimentacao.save!
    end
  end

  def saque(valor)
    Conta.transaction do
      self.saldo -= valor
      self.save!
      movimentacao = Movimentacao.new(conta_origem_id: self.id, conta_destino_id: self.id, valor: valor, tipo_movimentacao_id: TipoMovimentacao.get_id_by_nome("Saque"))
      movimentacao.save!
      return nil
    end
    rescue ActiveRecord::RecordInvalid => exception
      return exception.message
  end

  def self.transferencia(conta_origem, conta_destino, valor)
    #Essa deve ser uma transação atômica
    Conta.transaction do
      conta_origem.saldo -= valor
      conta_destino.saldo += valor
      conta_origem.save!
      conta_destino.save!
      movimentacao = Movimentacao.new(conta_origem_id: conta_origem.id, conta_destino_id: conta_destino.id, valor: valor, tipo_movimentacao_id: TipoMovimentacao.get_id_by_nome("Transferência"))
      movimentacao.save!
      return nil     
    end
    rescue ActiveRecord::RecordInvalid => exception
      return exception.message
  end

  def extrato(data_inicio, data_fim)
  end


end
