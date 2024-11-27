class Admin::SalesController < AdminController
  def index
    # Parse the date parameters or set default dates if none are provided
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today.end_of_month

    # Filter colors, products, paint_colors, and primary_colors by the date range
    @colors = Color.includes(:orders).where(orders: { created_at: start_date..end_date })
    @products = Product.includes(:orders).where(orders: { created_at: start_date..end_date })
    @paint_colors = PaintColor.includes(:orders).where(orders: { created_at: start_date..end_date })
    @primary_colors = PrimaryColor.includes(:orders).where(orders: { created_at: start_date..end_date })

    # Aggregate the sales data based on filtered orders
    @sales_data = {
      colors: @colors.map { |color| [color.name, color.orders.sum(:order_total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:order_total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:order_total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:order_total)] }.to_h,
    }
  end

  def download_pdf
    # Parse the date parameters
    start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today.end_of_month
  
    # Filter data by date range
    @colors = Color.includes(:orders).where(orders: { created_at: start_date..end_date })
    @products = Product.includes(:orders).where(orders: { created_at: start_date..end_date })
    @paint_colors = PaintColor.includes(:orders).where(orders: { created_at: start_date..end_date })
    @primary_colors = PrimaryColor.includes(:orders).where(orders: { created_at: start_date..end_date })
  
    # Rebuild the sales data hash for the PDF
    @sales_data = {
      colors: @colors.map { |color| [color.name, color.orders.sum(:order_total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:order_total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:order_total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:order_total)] }.to_h,
    }
  
    # Create PDF document
    pdf = Prawn::Document.new(page_layout: :portrait, page_size: 'A4', margin: 40)
    pdf.font_families.update("DejaVu" => {
      normal: "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf"
    })
    pdf.font "DejaVu"
  
    # Title and Date Range
    pdf.text "Sales Data Report", size: 24, style: , align: :center
    pdf.text "From #{start_date.strftime('%B %d, %Y')} to #{end_date.strftime('%B %d, %Y')}", size: 12, align: :center
    pdf.move_down 20
  
    # Helper method for adding sections
    def add_section(pdf, title, data)
      pdf.text title, size: 16, style:, color: "1E3E62"
      if data.empty?
        pdf.text "No sales data available.", size: 12, style: :italic, align: :center
      else
        pdf.move_down 10
        pdf.table(data.map { |key, value| [key, "₱#{value}"] }, 
                  column_widths: [300, 200],
                  row_colors: ["f9f9f9", "ffffff"],
                  cell_style: { borders: [:bottom], border_color: "dddddd", size: 12 }) do
          row(0).font_style = :normal
          row(0).background_color = "1E3E62"
          row(0).text_color = "ffffff"
        end
      end
      pdf.move_down 20
    end
  
    # Add each section to the PDF
    add_section(pdf, "Sales by Brand", @sales_data[:colors])
    add_section(pdf, "Sales by Product", @sales_data[:products])
    add_section(pdf, "Sales by Paint Color", @sales_data[:paint_colors])
    add_section(pdf, "Sales by Primary Color", @sales_data[:primary_colors])
  
    # Send the generated PDF
    send_data pdf.render, filename: "sales_data_#{start_date}_to_#{end_date}.pdf", type: "application/pdf", disposition: "attachment"
  end
  
end
