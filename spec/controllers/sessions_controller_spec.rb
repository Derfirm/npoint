# TODO(test): 401 on bad login, etc

RSpec.describe SessionsController do
  let!(:user) { create :user }

  def serializer
    UserSerializer
  end

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe '#info' do
    context 'with a logged in user' do
      before { sign_in user }

      it 'returns the logged in user info' do
        get :info
        expect(response).to have_http_status(200)
        expect(parsed_response).to eq(serialize_one(user))
        expect(parsed_response['has_documents']).to be(false)
      end

      it 'does not return the user id' do
        get :info
        expect(parsed_response['id']).to be_nil
      end

      context 'with documents' do
        let!(:doc) { create :document, user: user }

        it 'returns that the user has documents' do
          get :info
          expect(parsed_response['has_documents']).to be(true)
        end
      end
    end

    context 'without a logged in user' do
      it 'returns nothing' do
        get :info
        expect(response).to have_http_status(200)
        expect(parsed_response).to eq({})
      end
    end
  end
end
