Spree::Api::VariantsController.class_eval do

  protected

    def scope
      if @product
        variants = @product.variants_including_master
      else
        variants = Spree::Variant
      end

      if current_ability.can?(:manage, Spree::Variant) && params[:show_deleted]
        variants = variants.with_deleted
      end

      variants.includes(:product).where("#{Spree::Product.table_name}.published = ?", true).accessible_by(current_ability, :read)
    end


end
