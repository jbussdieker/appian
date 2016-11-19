class TerraformWorker
  include Sidekiq::Worker

  def perform
    with_tmpdir do
      File.open("main.tf", "w") do |f|
        f.write("# FOO")
      end
      puts `terraform apply`
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
