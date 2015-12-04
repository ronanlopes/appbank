class Conta < ActiveRecord::Base

  belongs_to :user

  scope :ativo, -> { where(ativo: true) }
  #Verificar i18n
  validates :saldo, :numericality => { :greater_than_or_equal_to => 0 }

  def saldo_to_s
    "R$ #{self.saldo/100},00"
  end

  def movimentacoes
    Movimentacao.where("conta_origem_id = ? OR conta_destino_id = ?", self.id, self.id)
  end

  def self.deposito(conta, valor)
    Conta.transaction do
      conta.saldo += valor
      conta.save!
      movimentacao = Movimentacao.new(conta_destino_id: conta.id, valor: valor, tipo_movimentacao_id: TipoMovimentacao.get_id_by_nome("Depósito"))
      movimentacao.save!
      return nil
    end
    rescue ActiveRecord::RecordInvalid => exception
      return exception.message
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

  def self.horario_comercial
    hora = DateTime.now.hour
    if Array(2..6).include? DateTime.now.wday && (hora >= 9 && hora <= 18)
      return true
    else
      return false
    end
  end

  def self.transferencia(conta_origem, conta_destino, valor)
    
    taxa = 0
    taxa += 10 if valor > 1000
    if horario_comercial
      taxa+=5
    else
      taxa+=7
    end
    Conta.transaction do
      conta_origem.saldo -= (valor+taxa)
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

  def extrato(data_inicio = DateTime.now.strftime("01/%m/%Y").to_datetime, data_fim = DateTime.now)
    self.movimentacoes.where(created_at: data_inicio..data_fim)
  end


end
