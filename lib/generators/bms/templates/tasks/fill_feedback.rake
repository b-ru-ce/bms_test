namespace :db do

  desc "Create page with purpose Contacts"
  task :fill_feedback => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/contacts').first || Page.find_by_title('Контакты')
    if page
      page.update_attributes(purpose: '/contacts')
    else Page.create!(title: "Контакты", text: "Текст описание самой страницы контактов<br>" + Populator.sentences(5), show_in_menu:true, sort:5, purpose:'/contacts'  )
    end

  end
end