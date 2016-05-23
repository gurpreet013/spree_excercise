Spree::Admin::ProductsController.class_eval do

  def update
    if params[:product][:taxon_ids].present?
      params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
    end
    if params[:product][:option_type_ids].present?
      params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
    end

    #this part is added
    if params[:product][:published].present?
      params[:product][:published_at] = DateTime.current
      params[:product][:publisher_id] = spree_current_user.id
    else
      params[:product][:published_at] = nil
      params[:product][:publisher_id] = nil
    end

    invoke_callbacks(:update, :before)
    if @object.update_attributes(permitted_resource_params)
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)
      respond_with(@object) do |format|
        format.html { redirect_to location_after_save }
        format.js   { render layout: false }
      end
    else
      # Stops people submitting blank slugs, causing errors when they try to
      # update the product again
      @product.slug = @product.slug_was if @product.slug.blank?
      invoke_callbacks(:update, :fails)
      respond_with(@object)
    end
  end

end
