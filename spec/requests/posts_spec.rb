require 'pry-byebug'
require 'rails_helper'

describe 'Posts requests' do

  before(:all) do
    Post.destroy_all #use this so it cleans up after itself
    @posts = FactoryGirl.create_list(:post, 25)
  end

  describe '#index' do
    it 'gets all of the posts' do
      get '/posts'
      expect(response).to be_success
# binding.byebug
      json = JSON.parse(response.body)
      expect(json.length).to eq 25

      #you can print the json now for troubleshooting:
      # p json
    end
  end #describe '#index'

  describe '#create' do
    it 'should create a new post and return it' do
      post '/posts',
      #Setup Stage of this test:
      # convert this ruby hash to json
      # write headers onto our post request
      # we're accepting the Mime type of JSON
      { post: {
          body: "Abcdefghijklmnopqrstuvwxyz",
          title: "ABC",
          author: "Nicole Pupillo"
        } }.to_json,
        #
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      #Expectations
      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON

      post = JSON.parse(response.body)
      expect(post['title']).to eq "ABC"
    end
  end #describe '#create'

  describe '#show' do
    it 'should retrieve a single post by id and return json' do
      @post = @posts.first
      get "/posts/#{@post.id}"
      expect(response).to be_success

      post = JSON.parse(response.body)
      expect(post['title']).to eq @post.title
    end
  end #describe '#show'

  describe '#update' do
    before(:all) do
      @post = @posts.first
    end
    it 'should update the parameters of the post and return that post' do
      put "/posts/#{@post.id}",
      { post: {
          title: "Something else",
          body: "A new body"
        }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON

      post = JSON.parse(response.body)
      expect(post['title']).to eq "Something else"
    end
  end #describe '#update'


  describe '#destroy' do
    it 'should kill the post' do
      post = @posts.first
      delete "/posts/#{post.id}"
      expect(response.status).to eq 202

      posts = JSON.parse(response.body)

      #expect 24 b/c we deleted 1 from the original 25
      expect(posts.length).to eq 24

    end
  end #describe '#destroy'


end
