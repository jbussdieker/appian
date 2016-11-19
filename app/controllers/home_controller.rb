class HomeController < ApplicationController
  def index
    TerraformWorker.perform_async
  end
end
