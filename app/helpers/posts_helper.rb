module PostsHelper
  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(HTMLwithPygments.new(hard_wrap: true),
                                          fenced_code_blocks: true,
                                          lax_html_blocks: true)
    @markdown.render(text).html_safe
  end
end
