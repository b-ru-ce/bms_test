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

    Article.populate 20 do |article|
      article.title = Populator.words(1..3).titleize
      article.date = 2.years.ago..Time.now
      article.short_text = Populator.sentences(2..10)
      article.text = Populator.sentences(20..30)
    end

  end
end