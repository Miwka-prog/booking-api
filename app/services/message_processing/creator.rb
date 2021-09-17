class MessageProcessing::Creator < ServiceBase
  attr_reader :message_params

  def self.create!(message_params)
    new(message_params).create_message
  end

  def initialize(message_params)
    super()

    @message_params = message_params
  end

  def create_message
    Message.find_or_create_by(@message_params)
  end
end
