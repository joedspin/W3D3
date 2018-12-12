# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
ShortenedUrl.destroy_all
Visit.destroy_all

user1 = User.create!(email: 'josh@email.com')
user2 = User.create!(email: 'joe@email.com')

short_url1 = ShortenedUrl.shorten(user1, 'THISISAVERYLONGURLTHISISAVEYLONGURLITSUREIS')
short_url2 = ShortenedUrl.shorten(user2, 'LORUSIPSUMIDONTREMBMEBERTHERESTOFTHELATIN')

Visit.record_visit!(user1, short_url1)
Visit.record_visit!(user1, short_url2)
Visit.record_visit!(user2, short_url1)
Visit.record_visit!(user2, short_url2)
Visit.record_visit!(user1, short_url1)

tt1 = TagTopic.create!(topic: 'sports', shortened_url_id: short_url1.id)
tt2 = TagTopic.create!(topic: 'entertainment', shortened_url_id: short_url2.id)
tt3 = TagTopic.create!(topic: 'news', shortened_url_id: short_url1.id)
tt4 = TagTopic.create!(topic: 'culture', shortened_url_id: short_url2.id)
tt5 = TagTopic.create!(topic: 'food', shortened_url_id: short_url1.id)

