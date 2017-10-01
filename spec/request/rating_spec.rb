describe 'rate a post', type: :request do
  let(:model) {
    Post::Create.new.call(title: Faker::Lorem.sentence(1), content: Faker::Lorem.sentence(10), login: 'test').right
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
    end
  end
end
