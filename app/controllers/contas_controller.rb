class ContasController < ApplicationController

  before_action :authenticate_user!, except: [:deposito_index, :realizar_deposito]
  before_action :check_conta_ativo, only: [:saque, :transferencia, :realizar_saque, :realizar_transferencia]

  def check_conta_ativo
    redirect_to minha_conta_index_path if !current_user.conta.ativo
  end

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
    if params[:extrato]
      d1, m1, y1 = params[:extrato][:data_inicio].split("/").map(&:to_i)
      d2, m2, y2 = params[:extrato][:data_fim].split("/").map(&:to_i)

      if (d1 && m1 && y1) && !Date.valid_date?(y1,m1,d1) || (d2 && m2 && y2) && !Date.valid_date?(y2,m2,d2) 
        redirect_to extrato_index_path, flash: {error: "Formato de data inválido. Favor utilizar dd/mm/aaaa" }
      elsif (!d1 || !m1 || !y1 || !d2 || !m2 || !y2)
        redirect_to extrato_index_path, flash: {error: "Formato de data inválido. Favor utilizar dd/mm/aaaa" }
      else  
        @data_inicio = params[:extrato][:data_inicio].try(:to_datetime)
        @data_fim = params[:extrato][:data_fim].try(:to_datetime)
      end
    end
    if (!@data_inicio || !@data_fim)
      @data_inicio = DateTime.now.strftime("01/%m/%Y").to_datetime
      @data_fim = DateTime.now
    end
    @movimentacoes = current_user.conta.extrato(@data_inicio, @data_fim).sort_by(&:created_at)
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

  def encerrar_conta
    conta = Conta.find(params[:id])
    conta.ativo = false
    conta.desativado_data = Date.today
    conta.save
    redirect_to minha_conta_index_path
  end

  def reabrir_conta
    conta = Conta.find(params[:id])
    conta.ativo = true
    conta.save
    redirect_to minha_conta_index_path
  end

end