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
end