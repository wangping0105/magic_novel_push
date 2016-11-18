module CrossSitesHelper
  def base_uri
    URI CROSS_SITE_CONFIG[:base][:host]
  end
end
