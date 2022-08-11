require 'rails_helper'

RSpec.describe 'Overrides::Registrations', type: :request do
  describe 'ユーザー作成' do
    context '有効な属性値の場合' do
      let(:client_params) { attributes_for(:client) }

      fit 'ユーザー作成・メール送信がされること' do
        expect(Client.count).to eq(0)
        expect(ActionMailer::Base.deliveries.count).to eq(0)

        post api_v1_user_registration_path, params: {
          registration: client_params,
          confirm_success_url: 'test1@example.com'
        }

        expect(Client.count).to eq(1)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        assert_response_schema_confirm(200)
      end
    end

    context '無効な属性値の場合' do
      let(:client_params) { attributes_for(:client, name: nil) }

      it 'ユーザー作成・メール送信がされないこと' do
        post api_v1_user_registration_path, params: {
          registration: client_params,
          confirm_success_url: 'test1@example.com'
        }
        expect(Client.count).to eq(0)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        assert_response_schema_confirm(422)
      end
    end
  end
end
