
  config.model Category do
    navigation_label 'Контент'
    weight -3
    nestable_tree({
                      position_field: :sort,
                      max_depth: 2
                  })

    list do
      field :title
      field :products
    end

    show do
      field :id
      field :title
      field :products
      field :title_of_window
      field :meta
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :products
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

  config.model Product do
    navigation_label 'Контент'
    weight -2
    nestable_list({ position_field: :sort })

    list do
      field :category
      field :title
      field :image
      field :price
    end

    show do
      field :id
      field :category
      field :title
      field :image
      field :price
      field :text
      field :title_of_window
      field :meta
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :category
        field :title
        field :image
        field :price
        field :text, :ck_editor
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

