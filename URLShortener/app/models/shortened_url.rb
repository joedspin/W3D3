# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true 

  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  
  has_many :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    class_name: 'Tagging',
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic
 
  def self.random_code
    shortened = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: shortened)
      shortened = SecureRandom.urlsafe_base64
    end
    shortened
  end

  def self.shorten(user, long_url)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: self.random_code)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    #self.visitors.where({ created_at: (Time.now - 10.minutes)..Time.now }).count
    self.visitors.where('visits.created_at > ?', 10.minutes.ago).count
  end

end 
