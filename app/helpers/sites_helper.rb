module SitesHelper
  def site_name
    ( request.env['GEMSMINE_SITE'] ||= {} )['name']
  end
end