require 'pry-byebug'
require 'rails_helper'

describe 'Comments requests' do

  #our comments rely on posts
  before(:all) do
    #use this so it cleans up after itself
    Comment.destroy_all
    Post.destroy_all

    @posts = FactoryGirl.create_list(:post, 25)
    @comments = FactoryGirl.create_list(:comment, 13)
  end

  describe '#index' do
    it 'gets all the comments for a post' do
# binding.byebug
      get "/posts/#{@posts.first.id}/comments"
      expect(response).to be_success
    end
  end

  describe '#create' do
    it 'should create a new comment and return the comment' do
      post "/posts/#{@posts.first.id}/comments",
        #Setup Stage of this test:
        # convert this ruby hash to json
        # write headers onto our post request
        # we're accepting the Mime type of JSON
        { comment: {
            body: "this is a comment body",
            author: "Nicole Pupillo"
          } }.to_json,
          #
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
        expect(response).to be_success
        expect(response.content_type).to be Mime::JSON
      end
    end #describe '#create'

    describe '#update' do
      it 'should update the comment and return that comment' do
        put "/comments/#{@comments.first.id}",
        { comment: {
            body: "Something else"
          }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response).to be_success
        expect(response.content_type).to be Mime::JSON
      end
    end #describe '#update'

  describe '#destroy' do
    it 'should kill the comment' do
      comment = @comments.first
      delete "/comments/#{comment.id}"
      expect(response.status).to eq 204
    end
  end #describe '#destroy'

end
