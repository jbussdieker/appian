json.extract! deployment, :id, :name, :project_id, :variables, :output, :status, :state, :created_at, :updated_at
json.url deployment_url(deployment, format: :json)