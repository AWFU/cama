#encoding: utf-8
module OrderlogsHelper
  def show_orderlogs(orderlogs)
    if(orderlogs.length > 0)
      return render(partial: "show_orderlogs", locals: { orderasks: orderlogs })
    else
      return nil
    end
  end
end