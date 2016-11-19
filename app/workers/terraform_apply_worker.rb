class TerraformApplyWorker
  include Sidekiq::Worker

  def perform(deployment_id, destroy = false)
    deployment = Deployment.find(deployment_id)

    deployment.update_attributes!(status: 1)

    with_tmpdir do
      puts "Writing provider.tf"
      File.open("provider.tf", "w") do |f|
        f.write(Provider.first.to_tf)
      end

      puts "Writing main.tf"
      File.open("main.tf", "w") do |f|
        f.write deployment.project.to_tf
      end

      unless deployment.state.to_s.empty?
        puts "Writing state"
        File.open("terraform.tfstate", "w") do |f|
          f.write deployment.state
        end
      end

      unless deployment.variables.to_s.empty?
        puts "Writing variables"
        File.open("terraform.tfvars", "w") do |f|
          f.write deployment.variables
        end
      end

      if destroy
        puts "Running destroy"
        puts `terraform destroy -force`
      else
        puts "Running apply"
        puts `terraform apply -input=false`
      end

      if $?.exitstatus == 0
        deployment.update_attributes!(status: 128)
      else
        deployment.update_attributes!(status: 255)
      end

      output = `terraform output -json`

      if $?.exitstatus == 0
        puts "Saving outputs"
        deployment.output = output
        deployment.save
      end

      if File.exists?("terraform.tfstate")
        puts "Saving state"
        deployment.state = File.read("terraform.tfstate")
        deployment.save
      end
    end

    deployment.destroy if destroy
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
