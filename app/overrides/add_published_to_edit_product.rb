Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
  :name => 'add_published_to_edit_product',
  :insert_after => "erb[loud]:contains('text_field :available_on')",
  :text => "
    <div data-hook='admin_product_form_available_on'>
      <%= f.field_container :published, class: ['form-group'] do %>
        <%= f.label :published %>
        <%= f.check_box :published, class: 'form-control' %>
      <% end %>
    </div>

  ")
