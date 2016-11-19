class TerraformWorker
  include Sidekiq::Worker

  def perform(command)
    puts `terraform #{command}`
  end
end
