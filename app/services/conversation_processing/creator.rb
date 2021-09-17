class ConversationProcessing::Creator < ServiceBase
  attr_reader :conversation_params

  def self.create!(conversation_params)
    new(conversation_params).create_conversation
  end

  def initialize(conversation_params)
    super()

    @conversation_params = conversation_params
  end

  def create_conversation
    Conversation.find_or_create_by(@conversation_params)
  end
end
