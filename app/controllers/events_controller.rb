class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def check
     @checkins = Checkin.where(event_id: @event.id)
  end

  def checkin
    if Card.exists?(:number => params["card"])
    #if Student.exists?(:card => params["card"])
      @checkstudent = Student.find_by(uin: Card.uin.find_by(number: params["card"]))
      print "***************", @checkstudent
      #@checkstudent = Student.where(:card => params["card"]).first
      if(@checkstudent)
        if Checkin.exists?(:event_id => @event.id, :student_id => @checkstudent.id)
          flash.now[:notice] = 'Student already checked in for this event!'
        else
          @cin = Checkin.create(:event_id => @event.id, :student_id => @checkstudent.id, :user_id => current_user.id)
          @cin.save
        end
      else
	  flash.now[:notice] = 'Card number found but student not found!'
	  @render_student = true
	  @card = params["card"]
      end
    else
      flash.now[:notice] = 'Card number not found!'
      @render_student = true
      @card = params["card"]
    end

    @checkins = Checkin.where(event_id: @event.id)
    respond_to do |format|
      format.js
    end
  end

  def checkback
    if Student.exists?(:uin => params["uin"])
      
      @cardstu = Card.create(:number => params["card"],:uin => params["uin"])
      @cardstu.save
      
      @chin = Checkin.create(:event_id => @event.id, :student_id => Student.find_by(uin: @cardstu.uin).id, :user_id => current_user.id)
      if @chin.save
        flash.now[:notice] = 'Student record created and checked in!'
      end
    else
      flash.now[:notice] = 'UIN not found! Check in Failed, Try again or Contact Admin'
    end  

    @checkins = Checkin.where(event_id: @event.id)
    respond_to do |format|
        format.js
    end
  end

  # GET /events
  # GET /events.json
  def index
    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific],
      :select_options => {
        sorted_by: Event.options_for_sorted_by
      }
    ) or return
    @events = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
      format.csv { 
        @events = @events.paginate(:page => params[:page], :per_page => @events.count)
        render text: @events.to_csv }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    puts "******REACHED*******"
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :year, :term, :date, :location, :time)
    end
end
