
  config.model PhotoGallery do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    configure :photos do
      visible true
    end

    list do
      field :title
    end

    show do
      field :id
      field :title
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :photos
      end

      group :seo do
        active false
        label 'SEO оптимизация'
        field :title_of_window do
          help 'Оставьте это поле пустым, если хотите оставить заголовок по умолчанию'
        end
        field :meta do
          help 'Оставьте это поле пустым, если хотите оставить мета теги по умолчанию'
        end
      end

    end
  end

  config.model Photo do
    visible false
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :photo_gallery
      field :image
      field :main
    end

    show do
      field :id
      field :photo_gallery
      field :image
      field :description
      field :main
      field :created_at
      field :updated_at
    end

    edit do
      field :image
      field :description
      field :main
      field :sort
    end
  end