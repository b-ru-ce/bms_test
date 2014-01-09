namespace :db do

  desc "Fill model Article"
  task :fill_news => :environment do

    require 'populator'
    require 'faker'

    Article.destroy_all

    Article.populate 20 do |article|
      article.title = Populator.words(1..3).titleize
      article.date = 2.years.ago..Time.now
      article.short_text = Populator.sentences(2..10)
      article.text = Populator.sentences(20..30)
    end

  end
end