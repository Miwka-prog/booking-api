class CommentProcessing::Updater < ServiceBase
  attr_reader :comment_id, :comment_params

  def self.update!(comment_id, comment_params)
    new(comment_id, comment_params).update_apartment
  end

  def initialize(comment_id, comment_params)
    super()
    @comment = comment(comment_id)
    @comment_params = comment_params
  end

  def update_apartment
    @comment.update!(@comment_params)
  end

  private

  def comment(comment_id)
    Comment.find_by(id: comment_id)
  end
end
