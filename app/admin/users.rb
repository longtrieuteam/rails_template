# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :username, :fullname, :phone, :password, :role_ids
  actions :all, except: %i[destroy]

  filter :username
  filter :fullname
  filter :phone
  filter :email

  index do
    selectable_column
    id_column
    column :username
    column :fullname
    column :phone
    column :email
    column :roles
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :username
      f.input :fullname
      f.input :phone
      f.input :email
      f.input :password
      f.input :roles, input_html: { name: 'user[role_ids]', multiple: false }
    end
    f.actions
  end

  show do
    attributes_table do
      row :username
      row :fullname
      row :phone
      row :email
      row :roles
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
