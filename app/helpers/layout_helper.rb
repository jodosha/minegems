module LayoutHelper
  def javascript(*scripts)
    content_for :javascript do
      scripts.map do |script|
        javascript_include_tag script
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

  private
    def gravatar_url(email)
      "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?d=identicon&s=12"
    end
end