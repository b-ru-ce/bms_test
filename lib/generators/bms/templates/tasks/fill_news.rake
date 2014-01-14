namespace :db do

  desc "Fill model Article"
  task :fill_news => :environment do

    require 'populator'
    require 'faker'


    page_news = Page.purpose('/news').first
    unless page_news.nil?
      page_news.delete
    end
    Page.create!(title:"Новости", text:"Текст описание самой страницы новостей<br>" + Populator.sentences(20..30), show_in_menu:true, sort:2, purpose:'/news'  )

    Article.destroy_all

    dates = ((Date.today - 10)..(Date.today + 10)).to_a
    20.times do
      article = Article.new title: Populator.words(1..3).titleize, date: dates.shuffle.first, short_text: Populator.sentences(2..10), text: Populator.sentences(20..30), image: File.new('vendor/bms/images/news.jpg')
      article.save(:validate => false)
    end

  end
end