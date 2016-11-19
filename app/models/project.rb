class Project < ActiveRecord::Base
  has_many :deployments

  def to_tf
    body
  end
end
