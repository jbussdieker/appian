require 'elasticsearch/persistence'

Elasticsearch::Persistence.client = Elasticsearch::Client.new host: 'elasticsearch'
Elasticsearch::Model.client = Elasticsearch::Client.new host: 'elasticsearch'
