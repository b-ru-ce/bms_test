
  config.model Feedback do
    navigation_label 'Общее'
    weight -2

    list do
      field :name
      field :phone
      field :email
      field :theme
      field :created_at
    end

    show do
      field :id
      field :name
      field :phone
      field :email
      field :theme
      field :text
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :phone
      field :email
      field :theme
      field :text
    end
  end