module SitesHelper
  def site_name
    ( request.env['MINEGEMS_SITE'] ||= {} )['name']
  end
end