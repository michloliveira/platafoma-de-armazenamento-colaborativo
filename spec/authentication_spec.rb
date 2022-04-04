require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
    let(:user) { User.create!(
        email: 'usertest@email.com',
        password: 'passwordtest123',
        password_confirmation: 'passwordtest123') }

        let(:url) { '/users/login' }
        let(:params) do
          {
            user: {
              login: user.email,
              password: user.password
            }       
          }
        end

        context 'when params are correct' do
            before do
              post url, params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
            end

            it 'returns 200' do
                expect(response).to have_http_status(200)
            end
        
            it 'returns JTW token in authorization header' do
                expect(response.headers['authorization']).to be_present
            end
        end
        
end
