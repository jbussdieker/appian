class HomeController < ApplicationController
  def index
    TerraformWorker.perform_async('version')
  end
end
