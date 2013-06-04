<div id="contact" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="contactLabel" aria-hidden="true">
  <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			&times;
		</button>
		<h3><%= t :contact_us %></h3>
	</div>
	<%= form_tag('/contact', :remote => true) do %>
	<div class="modal-body">

	</div>
	<div class="modal-footer">
		<p class="text-error pull-left"></p>
		<a href="#" class="btn" data-dismiss="modal" aria-hidden="true"><%= t :close %></a>
		<input type="submit" class="btn btn-primary" value="<%= t :send %>">
	</div>
	<% end %>
</div>
