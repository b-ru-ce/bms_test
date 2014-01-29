
  config.model PortfolioObject do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :title
      field :image
      field :short_text
    end

    show do
      field :id
      field :title
      field :image
      field :short_text
      field :text
      field :title_of_window
      field :meta
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :image
        field :short_text
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
