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
      colors: @colors.map { |color| [color.name, color.orders.sum(:total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:total)] }.to_h,
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
      colors: @colors.map { |color| [color.name, color.orders.sum(:total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:total)] }.to_h,
    }

    # Create PDF document
    pdf = Prawn::Document.new
    pdf.font_families.update("DejaVu" => {
      normal: "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf"
    })
    pdf.font "DejaVu"

    # Add PDF content
    pdf.text "Sales Data from #{start_date} to #{end_date}", align: :center, size: 24
    pdf.move_down 20

    pdf.text "Sales by Brand", style: :normal, size: 16
    @sales_data[:colors].each do |color, total|
      pdf.text "#{color}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    pdf.text "Sales by Product", style: :normal, size: 16
    @sales_data[:products].each do |product, total|
      pdf.text "#{product}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    pdf.text "Sales by Paint Color", style: :normal, size: 16
    @sales_data[:paint_colors].each do |paint_color, total|
      pdf.text "#{paint_color}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    pdf.text "Sales by Primary Color", style: :normal, size: 16
    @sales_data[:primary_colors].each do |primary_color, total|
      pdf.text "#{primary_color}: ₱#{total}", size: 12
    end

    send_data pdf.render, filename: "sales_data_#{start_date}_to_#{end_date}.pdf", type: "application/pdf", disposition: "attachment"
  end
end
