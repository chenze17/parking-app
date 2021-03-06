class ParkingsController < ApplicationController

  # Step1: 显示开始停车的表单
  def new
    @parking = Parking.new
  end

  # Step2： 新建一笔停车，记录下开始时间
  def create
    @parking = Parking.new( :start_at => Time.now )

    if current_user
      @parking.parking_type = params[:parking][:parking_type]
      @parking.user = current_user
    else
      @parking.parking_type = "guest"
    end
    @parking.save!

    redirect_to parking_path(@parking)
  end

  def show
    @parking = Parking.find(params[:id])
  end

  def update
    @parking = Parking.find(params[:id])
    @parking.end_at = Time.now
    @parking.calculate_amount

    @parking.save!

    redirect_to parking_path(@parking)
  end

end
