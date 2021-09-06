class CommentProcessing::Destroyer < ServiceBase
  attr_reader :comment

  def self.destroy!(comment)
    new(comment).destroy!
  end

  def initialize(comment)
    super()
    @comment = comment
  end

  def destroy!
    @comment.destroy!
  end
end
