module DeploymentsHelper
  def deployment_status(state)
    if state.to_s.empty?
      "unknown"
    elsif state == 0
      "pending"
    elsif state == 1
      content_tag :span, 'running', class: 'label label-success'
    elsif state == 128
      content_tag :span, 'idle', class: 'label label-default'
    elsif state == 255
      content_tag :span, 'failed', class: 'label label-danger'
    else
      "???"
    end
  end
end
