class ContasController < ApplicationController

  before_action :authenticate_user!, except: [:deposito_index, :realizar_deposito]

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
    data_inicio = params[:extrato][:data_inicio].try(:to_datetime) if params[:extrato]
    data_fim = params[:extrato][:data_fim].try(:to_datetime) if params[:extrato]
    @movimentacoes = current_user.conta.extrato(data_inicio, data_fim)
  end

  def minha_conta_index
    @usuario = current_user
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
    if Conta.deposito(Conta.find(params["movimentacao"]["conta_destino_id"].to_i), params["movimentacao"]["valor"].to_i)
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