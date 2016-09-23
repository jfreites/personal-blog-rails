module ApplicationHelper
	def article_cover url, options = {}
		html_class = options[:class]
		html_style = "background:url(#{url});"

		html = "<header class='intro-header #{html_class}' style='#{html_style}'>"

		html.html_safe
	end
end
