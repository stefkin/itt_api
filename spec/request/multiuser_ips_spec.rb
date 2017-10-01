require 'rails_helper'

describe 'multiuser ips', type: :request do
  context 'there is an ip with multiple users' do
    before do
      Post::Create.new.call(login: 'foo', title: Faker::Lorem.sentence(1),
                            content: Faker::Lorem.sentence(10), author_ip: '1.2.3.4')

      Post::Create.new.call(login: 'bar', title: Faker::Lorem.sentence(1),
                            content: Faker::Lorem.sentence(10), author_ip: '1.2.3.4')

      Post::Create.new.call(login: 'baz', title: Faker::Lorem.sentence(1),
                            content: Faker::Lorem.sentence(10), author_ip: '1.1.1.1')
    end

    context 'and a user who posted from a single one' do
      it 'should return the first user and his ips' do
        get '/multiuser_ips'
        body = JSON.parse(response.body).with_indifferent_access
        collection = body[:multiuser_ips]
        expect(collection.count).to eq 1
        expect(collection.first['logins']).to match_array ['foo', 'bar']
        expect(collection.first['author_ip']).to eq "1.2.3.4"
      end

      it 'should perform under 100 ms' do
        expect { get '/multiuser_ips' }.to perform_under(100).ms
      end
    end
  end
end
