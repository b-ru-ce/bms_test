
  config.model Slide do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :title
      field :image
      field :url
    end

    show do
      field :id
      field :title
      field :image
      field :url
      field :text
      field :created_at
      field :updated_at
    end

    edit do
      field :title
      field :image
      field :url
      field :text, :ck_editor
    end
  end

