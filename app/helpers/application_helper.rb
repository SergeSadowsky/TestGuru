module ApplicationHelper
  def current_year
    Date.today.year
  end

  def github_url(author:, repo:)
    link_to author,
            repo.to_s,
            target: '_blank'
  end

  def flash_helper
    content_tag :div do
      flash.each do |key, message|
        concat content_tag :p, message, class: "flash #{key}"
      end
    end

  end
end
