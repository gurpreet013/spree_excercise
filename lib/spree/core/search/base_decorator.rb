Spree::Core::Search::Base.class_eval do

  protected

    def get_base_scope
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords)
      base_scope = add_search_scopes(base_scope)
      base_scope = add_eagerload_scopes(base_scope)
      get_published_products base_scope
    end

    def get_published_products(base_scope)
      base_scope.where(published: true)
    end

end
