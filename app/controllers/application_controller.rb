class ApplicationController < ActionController::Base
  def hello
    render html: "πΊπ¦"
  end
end
