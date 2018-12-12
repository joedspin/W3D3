# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint(8)        not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ActiveRecord::Base

  has_many :taggings,
    class_name: 'Taggings',
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_many :urls,
    through: :taggings,
    source: :url

end
