require 'rails_helper'

RSpec.describe 'create post', type: :request do
  let(:ip) { '37.212.61.44' }
  let(:title) { Faker::Lorem.sentence(1) }
  let(:text) { Faker::Lorem.sentence(10) }
  let(:login) { Faker::Internet.user_name }

  let(:params) {
    {
      post: {
         author_ip: ip,
         title: title,
         content: text,
         login: login
      }
    }
  }

  context 'author does not exist yet' do
    before { post '/posts', params: params }

    it 'should create author automatically along with the post' do
      expect(User.find_by_login(login)).to be
      post = Post.find_by_author_ip(ip)
      expect(post).to have_attributes params[:post].except(:login)
    end

    it 'should respond with attributes' do
      post = JSON.parse(response.body).with_indifferent_access[:post]
      expect(post).to include params[:post].except(:login)
    end

    it 'should perform under 100ms' do
      expect { post '/posts', params: params }.to perform_under(100).ms
    end
  end

  context 'author does exist' do
    let!(:author) { User.create login: login }

    it 'should NOT create author automatically along with the post' do
      expect { post '/posts', params: params }.not_to change { User.count }
    end
  end

  context 'author login is too short' do
    let(:login) { "X" }
    before { post '/posts', params: params }

    it 'should respond with 422 and errors' do
      expect(response.status).to eq 422
      errors = JSON.parse(response.body).with_indifferent_access[:errors]
      expect(errors).to eq({ "login" => ['size cannot be less than 3']})
    end
  end
end
