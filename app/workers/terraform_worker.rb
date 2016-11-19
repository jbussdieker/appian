class TerraformWorker
  include Sidekiq::Worker

  def perform(command)
    with_tmpdir do
      puts `terraform #{command} && pwd`
    end
  end

  private

  def with_tmpdir(&block)
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        yield
      end
    end
  end
end
