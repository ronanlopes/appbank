class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :conta

  has_many :movimentacoes, through: :conta

  before_create :create_conta

  def create_conta
    self.build_conta({saldo: 0})
  end

end
