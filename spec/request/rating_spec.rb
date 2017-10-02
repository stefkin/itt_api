describe 'rate a post', type: :request do
  let(:model) {
    Post::Create.new.call(title: Faker::Lorem.sentence(1), content: Faker::Lorem.sentence(10), login: 'test', author_ip: Faker::Internet.ip_v4_address).right
  }
  let(:params) {
    { rating: { post_id: model.id, value: 3 } }
  }

  context 'rate an existing post' do
    it 'should return avg rating of the post' do
      post '/ratings', params: params

      body = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to be 200
      expect(body[:avg_value]).to eq "3.0"

      expect { post '/ratings', params: params }.to perform_under(100).ms
    end
  end

  context 'rate post that does not exist' do
    it 'should return 422 with errors' do
      post '/ratings', params: { rating: { post_id: -1, value: 2 } }

      body = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to be 422
      expect(body[:errors]).to eq ["Post must exist"]
    end
  end

  context 'rate with value out of range' do
    it 'should return 422 with errors' do
      post '/ratings', params: { rating: { post_id: model.id, value: 6 } }

      body = JSON.parse(response.body).with_indifferent_access
      expect(response.status).to be 422
      expect(body[:errors]).to eq({ "value" => ["must be one of: 1 - 5"] })
    end
  end
end
