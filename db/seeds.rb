# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'spomatch@example.com',
  password: 'spomatch',
)

# タグに関する初期データ
tags = %w(サッカー 野球 テニス フットサル バトミントン 卓球)
tags.each do |tag|
  Tag.create!(name: tag)
end

# スポーツジャンルに関する初期データ
sports = %w(サッカー 野球 テニス フットサル バトミントン 卓球)
sports.each do |sport|
  Sport.create!(name: sport)
end

# ユーザーに関するテストデータ
[
  ['1','test1@example.com', 'ユーザー1', 'spomatch'],
  ['2','test2@example.com', 'ユーザー2', 'spomatch'],
  ['3','test3@example.com', 'ユーザー3', 'spomatch'],
  ['4','test4@example.com', 'ユーザー4', 'spomatch'],
  ['5','test5@example.com', 'ユーザー5', 'spomatch'],
  ['6','test6@example.com', 'ユーザー6', 'spomatch'],
  ['7','test7@example.com', 'ユーザー7', 'spomatch'],
  ['8','test8@example.com', 'ユーザー8', 'spomatch'],
  ['9','test9@example.com', 'ユーザー9', 'spomatch'],
  ['10','test10@example.com', 'ユーザー10', 'spomatch'],
  ['11','test11@example.com', 'ユーザー11', 'spomatch'],
  ['12','test12@example.com', 'ユーザー12', 'spomatch'],
  ['13','test13@example.com', 'ユーザー13', 'spomatch'],
  ['14','test14@example.com', 'ユーザー14', 'spomatch'],
].each do |id, mail, name, password|
    User.create!(
      { id: id, email: mail, name: name, password: password}
    )
  end