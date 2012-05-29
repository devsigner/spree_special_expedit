# -*- encoding : utf-8 -*-
Admin::GeneralSettingsController.class_eval do
    
  def show
    @preferences = ['site_name', 'default_seo_title', 'default_meta_keywords',
      'default_meta_description', 'site_url', 'sample_default_weight']
  end
  
  def edit
    @preferences = ['site_name', 'default_seo_title', 'default_meta_keywords',
      'default_meta_description', 'site_url', 'allow_ssl_in_production',
      'allow_ssl_in_development_and_test', 'sample_default_weight']
  end    
    
end    
