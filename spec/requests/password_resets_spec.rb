require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do 
  let(:user) { FactoryGirl.create(:user) }
  it "Manda email de redefinição de senha para o usuário" do
    visit unauthenticated_root_path
    click_link "Esqueceu"
    fill_in "Email", with: user.email
    click_button "Enviar instruções de redefinição de senha"
    page.should have_content("você receberá")
    #last_email.to.should include(user.email)
  end
end