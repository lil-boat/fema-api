require 'rails_helper'

RSpec.describe 'Declarations API', type: :request do
  # initialize test data
  let!(:declarations) { create_list(:declaration, 10) }
  let(:declaration_id) { declarations.first.id }

  # Test suite for GET /declarations
  describe 'GET /declarations' do
    # make HTTP get request before each example
    before { get '/declarations' }

    it 'returns declarations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /declarations/:id
  describe 'GET /declarations/:id' do
    before { get "/declarations/#{declaration_id}" }

    context 'when the record exists' do
      it 'returns the declaration' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(declaration_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:declaration_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Declaration/)
      end
    end
  end
end