class Admin::SalesController < AdminController
  def index
    @colors = Color.includes(:orders) # Assuming Color model is related to Order
    @products = Product.includes(:orders) # Assuming Product model is related to Order
    @paint_colors = PaintColor.includes(:orders) # Assuming PaintColor model is related to Order
    @primary_colors = PrimaryColor.includes(:orders) # Assuming PrimaryColor model is related to Order

    @sales_data = {
      colors: @colors.map { |color| [color.name, color.orders.sum(:total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:total)] }.to_h,
    }
  end

  def download_pdf
    # Fetch the necessary data again in the download_pdf action
    @colors = Color.includes(:orders)
    @products = Product.includes(:orders)
    @paint_colors = PaintColor.includes(:orders)
    @primary_colors = PrimaryColor.includes(:orders)

    # Build the sales data hash
    @sales_data = {
      colors: @colors.map { |color| [color.name, color.orders.sum(:total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.name, primary_color.orders.sum(:total)] }.to_h,
    }

    # Create a new PDF document
    pdf = Prawn::Document.new

    # Register the DejaVu font family with Prawn
    pdf.font_families.update("DejaVu" => {
      normal: "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf",

    })

    # Use the registered font family "DejaVu"
    pdf.font "DejaVu"

    # Add a title
    pdf.text "Sales Data", align: :center, size: 24, style: :normal
    pdf.move_down 20

    # Sales by Brand section
    pdf.text "Sales by Brand", style: :normal, size: 16
    @sales_data[:colors].each do |color, total|
      pdf.text "#{color}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    # Sales by Product section
    pdf.text "Sales by Product", style: :normal, size: 16
    @sales_data[:products].each do |product, total|
      pdf.text "#{product}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    # Sales by Paint Color section
    pdf.text "Sales by Paint Color", style: :normal, size: 16
    @sales_data[:paint_colors].each do |paint_color, total|
      pdf.text "#{paint_color}: ₱#{total}", size: 12
    end
    pdf.move_down 10

    # Sales by Primary Color section
    pdf.text "Sales by Primary Color", style: :normal, size: 16
    @sales_data[:primary_colors].each do |primary_color, total|
      pdf.text "#{primary_color}: ₱#{total}", size: 12
    end

    # Send the PDF as a downloadable file
    send_data pdf.render, filename: "sales_data.pdf", type: "application/pdf", disposition: "attachment"
  end
end
