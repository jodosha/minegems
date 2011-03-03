module LayoutHelper
  GOOGLE_ANALYTICS = <<-CODE
  <script type="text/javascript">

    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-21800011-1']);
    _gaq.push(['_setDomainName', '.minege.ms']);
    _gaq.push(['_trackPageview']);

    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();

  </script>
  CODE

  def javascript(*scripts)
    content_for :javascript do
      scripts.map do |script|
        javascript_include_tag script
      end.join("\n").html_safe
    end
  end

  def stylesheet(*stylesheets)
    content_for :stylesheet do
      stylesheets.map do |stylesheet|
        stylesheet_link_tag stylesheet
      end.join("\n").html_safe
    end
  end

  def flash_messages
    [ :notice, :alert ].map do |message|
      if content = send(message)
        content_tag(:div, content, :class => message.to_s)
      end
    end.join("\n").html_safe
  end

  def organization_avatar(site)
    image_tag('company.png', :size => "96x96", :alt => "#{site.name} avatar")
  end

  def gravatar(user)
    %(<img src="#{gravatar_url(user.email)}" width="12px" height="12px" />).html_safe
  end

  def google_analytics
    if Rails.env.production?
      GOOGLE_ANALYTICS.html_safe
    end
  end

  private
    def gravatar_url(email)
      "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?d=identicon&s=12"
    end
end