# frozen_string_literal: true

# Rails' built-in :back path uses the `Referer` header, or falls back javascript: "history.back()".
# For that reason it doesn't work well for forms that were submitted with invalid data.
# In those cases, it will have to be pressed twice to actually go back to the page before the form.
#
# The helpers below makes it easy to "remember" the backlink between form submissions, and to
# provide a fallback in case there's no referrer available.
module BackLinkHelper
  def back_path_field(fallback: nil)
    hidden_field_tag(:back_path, back_path(fallback: fallback))
  end

  def back_path(fallback: nil)
    # _filtered_referrer is part of rails' internal code for generating back links.
    # In case the API changes we can copy the original method from here:
    # https://github.com/rails/rails/blob/01f58d62c2f31f42d0184e0add2b6aa710513695/actionview/lib/action_view/helpers/url_helper.rb#L52
    params["back_path"] || _filtered_referrer || fallback
  end
end
