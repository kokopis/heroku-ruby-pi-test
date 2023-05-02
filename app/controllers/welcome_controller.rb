class WelcomeController < ApplicationController
  def index
    json = { response: "The time is now #{Time.now}. Ruby version #{RUBY_VERSION}" }
    render status: :ok, json: json
  end
end
