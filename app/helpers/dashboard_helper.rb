module DashboardHelper

  # Created HTML for dashboard cards as follows:
  # <div class="col-xl-3 col-md-6 mb-4">
  #   <div class="card border-left-primary shadow h-100 py-2 border border-white bg-dark">
  #     <div class="card-body">
  #       <div class="row no-gutters align-items-center">
  #         <div class="col mr-2">
  #           <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
  #             <<TITULO>>
  #           </div>
  #           <div class="h5 mb-0 font-weight-bold text-gray-800">
  #             <<CONTEUDO>>
  #           </div>
  #         </div>
  #       </div>
  #     </div>
  #   </div>
  # </div>
  def dashboard_card(title, &block)
    content_tag(:div, class: "col-xl-3 col-md-6 mb-4") do
      content_tag(:div, class: 'card border-left-primary shadow h-100 py-2 border border-white bg-dark') do
        content_tag(:div, class: 'card-body') do
          content_tag(:div, class: 'row no-gutters align-items-center') do
            content_tag(:div, class: 'col mr-2') do
              content_tag(:div, title, class: 'text-xs font-weight-bold text-primary text-uppercase mb-1') +
              content_tag(:div, capture(&block), class: 'h5 mb-0 font-weight-bold text-gray-800')
            end
          end
        end
      end
    end
  end
end
