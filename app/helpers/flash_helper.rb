module FlashHelper
  ALERT_CLASSES = { notice: "alert-success", alert: "alert-warning", error: "alert-danger" }.freeze

  def alert_class(type)
    ALERT_CLASSES[type.to_sym] || ALERT_CLASSES[:notice]
  end
end
