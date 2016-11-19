class TerraformWorker
  include Sidekiq::Worker

  def perform
    with_tmpdir do
      File.open("provider.tf", "w") do |f|
        f.write(Provider.first.to_tf)
      end

      File.open("instance.tf", "w") do |f|
        f.write <<-EOS
          resource "aws_instance" "example" {
            ami           = "ami-0d729a60"
            instance_type = "t2.micro"
          }
        EOS
      end

      puts `terraform apply`
      puts `terraform output -json`
      if File.exists?("terraform.tfstate")
        puts File.read("terraform.tfstate")
      end
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
