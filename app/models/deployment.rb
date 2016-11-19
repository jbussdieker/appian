class Deployment < ActiveRecord::Base
  include Elasticsearch::Model

  belongs_to :project
end
