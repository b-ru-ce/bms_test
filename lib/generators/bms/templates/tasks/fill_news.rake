namespace :db do

  desc "Fill model Article"
  task :fill_news => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/news').first || Page.find_by_title('Новости')
    if page
      page.update_attributes(purpose: '/news')
    else Page.create!(title:"Новости", text:"Текст описание самой страницы новостей<br>" + Populator.sentences(20..30), show_in_menu:true, sort:2, purpose:'/news'  )
    end

    Article.destroy_all

    dates = ((Date.today - 10)..(Date.today + 10)).to_a
    20.times do
      article = Article.new title: Populator.words(1..3).titleize, date: dates.shuffle.first, short_text: Populator.sentences(2..10), text: Populator.sentences(20..30), image: File.new('vendor/bms/images/news.jpg')
      article.save(:validate => false)
    end

  end
end