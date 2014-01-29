namespace :db do

  desc 'Fill model PortfolioObject'
  task :fill_portfolio => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/portfolio').first || Page.find_by_title('Портфолио')
    if page
      page.update_attributes(purpose: '/portfolio')
    else Page.create!(title: 'Портфолио', text: '', show_in_menu: true, sort: 7, purpose: '/portfolio' )
    end

    PortfolioObject.destroy_all
    15.times {|i| PortfolioObject.create title: Populator.words(2..3), image: File.new('vendor/bms/images/portfolio.jpg'), short_text: Populator.sentences(3), text: Populator.sentences(7)}

  end
end