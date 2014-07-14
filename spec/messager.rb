# Simple counter class
class Messager
  def initialize(app, message = 'Message')
    @app = app
    @message = message
  end

  def call
    result = @app.call
    result.push @message
    result
  end
end
