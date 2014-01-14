
  config.model Review do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :name
      field :image
      field :desc
      field :show_on_main
    end

    show do
      field :id
      field :name
      field :image
      field :desc
      field :short_text
      field :text
      field :show_on_main
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :image
      field :desc
      field :short_text
      field :text, :ck_editor
      field :show_on_main
    end
  end