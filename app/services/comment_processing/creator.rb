class CommentProcessing::Creator < ServiceBase
  attr_reader :comment_params

  def self.create!(comment_params)
    new(comment_params).create_apartment
  end

  def initialize(comment_params)
    super()

    @comment_params = comment_params
  end

  def create_apartment
    Comment.find_or_create_by(@comment_params)
  end
end
