<%- if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations' %>
  <%= link_to "Esqueceu sua senha?", new_password_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.confirmable? && controller_name != 'confirmations' %>
  <%= link_to "Didn't receive confirmation instructions?", new_confirmation_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.lockable? && resource_class.unlock_strategy_enabled?(:email) && controller_name != 'unlocks' %>
  <%= link_to "Didn't receive unlock instructions?", new_unlock_path(resource_name) %><br />
<% end %>

<%- if devise_mapping.omniauthable? %>
  <%- resource_class.omniauth_providers.each do |provider| %>
    <%= link_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(resource_name, provider), method: :post %><br />
  <% end %>
<% end %>