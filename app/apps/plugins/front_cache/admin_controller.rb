module Plugins
  module FrontCache
    class AdminController < CamaleonCms::Apps::PluginsAdminController
      include Plugins::FrontCache::FrontCacheHelper
      def settings
        @caches = current_site.get_meta('front_cache_elements', { paths: [] })
        @caches[:paths] << '' unless @caches[:paths].present?
      end

      def save_settings
        current_site.set_meta('front_cache_elements', { paths: ((params[:cache][:paths] || []).delete_if do |a|
                                                                  !a.present?
                                                                end || []),
                                                        posts: (params[:cache][:posts] || []),
                                                        post_types: (params[:cache][:post_type] || []),
                                                        skip_posts: (params[:cache][:skip_posts] || []),
                                                        cache_login: params[:cache][:cache_login],
                                                        home: params[:cache][:home],
                                                        preserve_cache_on_restart: params[:cache][:preserve_cache_on_restart],
                                                        invalidate_only: params[:cache][:invalidate_only],
                                                        cache_counter: current_site.get_meta('front_cache_elements')[:cache_counter] || 0 })
        flash[:notice] = t('plugin.front_cache.message.settings_saved').to_s
        redirect_to action: :settings
      end

      def clean_cache
        flash[:notice] = t('plugin.front_cache.message.cache_destroyed').to_s
        front_cache_clean
        redirect_to(request.referer || '/admin/plugins')
      end
    end
  end
end
