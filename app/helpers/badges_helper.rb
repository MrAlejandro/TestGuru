module BadgesHelper
  def badge_image(badge)
    if badge.image_url =~ URI::regexp
      image_tag(badge.image_url, class: 'badge-image')
    else
      ''
    end
  end
end
