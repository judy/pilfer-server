class Profile < ActiveRecord::Base
  attr_accessible :hostname, :pid, :description, :payload, :file_sources

  serialize :payload, JSON
  serialize :file_sources, JSON

  belongs_to :app

  scope :latest, limit(50).order('id DESC')

  def total_time
    payload['files'].inject(0) {|total, (file, data)|
      total + data['total']
    }
  end
end
