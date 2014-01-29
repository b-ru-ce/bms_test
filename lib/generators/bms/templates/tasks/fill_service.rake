namespace :db do

  desc 'Fill model Service'
  task :fill_service => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/services').first || Page.find_by_title('Услуги')
    if page
      page.update_attributes(purpose: '/services')
    else Page.create!(title: 'Услуги', text: '', show_in_menu: true, sort: 8, purpose: '/services' )
    end

    Service.destroy_all
    15.times {|i| Service.create title: Populator.words(2..3), image: File.new('vendor/bms/images/service.jpg'), short_text: Populator.sentences(3), text: Populator.sentences(7)}

  end
end