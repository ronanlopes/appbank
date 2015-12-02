class Conta < ActiveRecord::Base
  belongs_to :user

  #Verificar i18n
  validates :saldo, :numericality => { :greater_than => 0 }

  def saldo_to_s
    "R$ #{self.saldo/100}"
  end

  def deposito(valor)
    self.saldo += valor
    self.save
  end

  def saque(valor)
    self.saldo -= valor
    self.save
    logger.debug 88888888888888
    logger.debug self.errors.full_messages
  end

  def self.transferencia(conta_origem, conta_destino, valor)
    #Essa deve ser uma transação atômica
    conta_origem -= valor
    conta_destino += valor
    conta_origem.save
    conta_destino.save
  end

  def extrato(data_inicio, data_fim)
  end


end
