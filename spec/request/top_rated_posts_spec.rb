require 'rails_helper'

describe 'top rated posts', type: :request do
  before {
    10.times do
      post_id = Post::Create.new.call(login: Faker::Internet.user_name, title: Faker::Lorem.sentence(1), content: Faker::Lorem.sentence(10), author_ip: Faker::Internet.ip_v4_address).right.id

      3.times do
        Rating::Create.new.call(post_id: post_id, value: Random.rand(5)) # max value is 4 here
      end
    end

    top_post_id = Post::Create.new.call(login: Faker::Internet.user_name, title: 'Top post', content: 'Top content', author_ip: Faker::Internet.ip_v4_address).right.id

    Rating::Create.new.call(post_id: top_post_id, value: 5)
  }

  context 'N = 5' do
    it 'should get top 5 posts' do
      get '/posts', params: { count: 5 }
      body = JSON.parse(response.body).with_indifferent_access
      posts = body[:posts]
      expect(posts.count).to eq 5
      expect(posts.first).to include title: 'Top post', content: 'Top content'

    end

    it 'should perform under 100ms' do
      expect { get '/posts', params: { count: 5 } }.to perform_under(100).ms
    end
  end
end
