module LayoutHelper
  def javascript(*scripts)
    content_for :javascript do
      scripts.map do |script|
        javascript_include_tag script
      end.join("\n").html_safe
    end
  end
end