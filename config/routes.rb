Rails.application.routes.draw do
 
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'application#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get '/saque' => 'contas#saque_index', as: :saque_index
  get '/deposito' => 'contas#deposito_index', as: :deposito_index
  get '/transferencia' => 'contas#transferencia_index', as: :transferencia_index
  get '/minha_conta' => 'contas#minha_conta_index', as: :minha_conta_index
  match '/extrato' => 'contas#extrato_index', as: :extrato_index, via: [:get, :post]
  post '/realizar_saque' => 'contas#realizar_saque', as: :realizar_saque
  post '/realizar_deposito' => 'contas#realizar_deposito', as: :realizar_deposito
  post '/realizar_transferencia' => 'contas#realizar_transferencia', as: :realizar_transferencia


end
