#encoding: utf-8
module OrderlogsHelper
  def show_orderlogs(orderlogs)
    if(orderlogs.length > 0)
      return render(partial: "show_orderlogs", locals: { orderlogs: orderlogs })
    else
      return nil
    end
  end

  def show_latest_orderlogs(orderlogs)
    if(orderlogs.length > 0)
      return render(partial: "show_latest_orderlogs", locals: { orderlogs: orderlogs })
    else
      return nil
    end
  end

end