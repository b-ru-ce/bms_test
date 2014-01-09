
  config.model Article do
    navigation_label 'Контент'
    weight -1

    list do
      field :date
      field :title
      field :short_text
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :date
        field :short_text
        field :text, :ck_editor
        field :image
      end

      group :seo do
        label "SEO-оптимизация"
        field :title_of_window
        field :meta
      end

    end

    show do
      field :id
      field :date
      field :title
      field :image
      field :short_text
      field :text
      field :title_of_window
      field :created_at
      field :updated_at
    end
  end
