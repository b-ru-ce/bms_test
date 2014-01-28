namespace :db do

  desc 'Fill model Category and Product'
  task :fill_catalog => :environment do

    require 'populator'
    require 'faker'

    page = Page.purpose('/catalog').first || Page.find_by_title('Каталог')
    if page
      page.update_attributes(purpose: '/catalog')
    else Page.create!(title: 'Каталог', text: '', show_in_menu: true, sort: 5, purpose: '/catalog' )
    end

    Category.destroy_all

    cat1 = Category.create!(:title => 'Родительская категория 1')
    cat2 = Category.create!(:title => 'Родительская категория 2')

    3.times {|i| Category.create! :title => "Категория #{cat1.id + 1}#{i+1}", :parent => cat1}
    3.times {|i| Category.create! :title => "Категория #{cat2.id + 1}#{i+1}", :parent => cat2}

    cat_with_products = Category.roots.first.children.first

    15.times {|i| cat_with_products.products.create title: "Товар #{i}", image: File.new('vendor/bms/images/catalog.jpg'), price: rand(10000) + 2000, text: Populator.sentences(5)}

  end
end