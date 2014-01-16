namespace :db do

  desc "Fill pages"
  task :fill_pages => :environment do

    require 'populator'
    require 'faker'

    Page.destroy_all

    Page.create!(title:"Главная", text:"Текст описание самой главной страницы<br>" + Populator.sentences(50..100), show_in_menu:true, sort:1, purpose:'/'  )
    Page.create!(title:"О нас", text:"Текст описание страницы О нас<br>" + Populator.sentences(50..100), show_in_menu:true, sort:2  )

  end
end