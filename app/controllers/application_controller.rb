class ApplicationController < ActionController::Base
  def hello
    render html: "🇺🇦"
  end
end
