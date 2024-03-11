module ApplicationHelper
  def flash_message(type)
    return unless flash[type].present?
    class_name = case type
                 when :notice
                   "bg-green-100 border border-green-400 text-green-700"
                 when :alert
                   "bg-red-100 border border-red-400 text-red-700"
                 else
                   ""
                 end
    content_tag(:div, flash[type], class: "mt-20 #{class_name} px-4 py-3 rounded relative mb-2", role: "alert")
  end
end
