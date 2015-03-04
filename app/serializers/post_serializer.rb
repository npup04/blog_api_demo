require 'pry-byebug'
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :author, :created_at

  # how to override attributes w/ serializers, such as :created_at
  # b/c created_at by default is not a reader friendly format
  def created_at
# binding.byebug
    # object.created_at.strftime('%Y-%m-%d')

  end

end
