class Provider < ActiveRecord::Base
  serialize :configuration

  self.inheritance_column = nil

  def configuration=(value)
    if value.kind_of? String
      super(YAML.load(value))
    end
  end

  def to_h
    { "provider" => { type => configuration } }
  end
end
