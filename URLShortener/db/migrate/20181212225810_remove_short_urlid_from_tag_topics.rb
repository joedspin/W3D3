class RemoveShortUrlidFromTagTopics < ActiveRecord::Migration[5.2]
  def change
    remove_column :tag_topics, :shortened_url_id
  end
end
