class ErrorSerializer
  def self.format_error(message)
    { data:
          { error: message } }
  end
end