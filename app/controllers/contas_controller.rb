class ContasController < ApplicationController

  def saque_index 
    @saque = Movimentacao.new 
  end

  def deposito_index
    @deposito = Movimentacao.new 
  end

  def transferencia_index
    @transferencia = Movimentacao.new
  end

  def extrato_index
    @movimentacoes = current_user.conta.movimentacoes
  end

  def realizar_saque
    erros = current_user.conta.saque(params["movimentacao"]["valor"].to_i)
    if erros.nil?
      redirect_to saque_index_path, notice: 'Saque realizado com sucesso.'
    else
      redirect_to saque_index_path, flash: { error: erros }
    end
  end

  def realizar_deposito
    if current_user.conta.deposito(params["movimentacao"]["valor"].to_i)
      redirect_to deposito_index_path, notice: 'Depósito realizado com sucesso.'
    else
      redirect_to deposito_index_path, notice: 'Não foi possível realizar o depósito.'
    end
  end

  def realizar_transferencia
    erros = Conta.transferencia(current_user.conta, Conta.find(params["movimentacao"]["conta_destino_id"].to_i), params["movimentacao"]["valor"].to_i)
    if erros.nil?
      redirect_to transferencia_index_path, notice: 'Transferência realizada com sucesso.'
    else
      redirect_to transferencia_index_path, flash: { error: erros }
    end
  end

end