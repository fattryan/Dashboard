class QuartersController < ApplicationController
  # GET /quarters
  # GET /quarters.json
  def index
    @quarters = Quarter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quarters }
    end
  end

  # GET /quarters/1
  # GET /quarters/1.json
  def show
    @clients = Client.all
    @quarters = Quarter.all
    @quarter = Quarter.find(params[:id])
    
     #Set the current quarter
      if Date.today.month <= 3  
			  @this_quarter = 1
		  elsif Date.today.month >= 4 and Date.today.month <= 6
			  @this_quarter = 2
		  elsif Date.today.month >= 7 and Date.today.month <= 9
			  @this_quarter = 3
		  else Date.today.month >= 10 and Date.today.month <= 12
			  @this_quarter = 4
		  end

       # Last Quarter for @client
    	  if @quarter.quarter >= 2
    	  @lastqtr = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?', 
    	  @quarter.client_id, @quarter.quarter-1, @quarter.year)
    	  else @quarter.quarter == 1
    	  @lastqtr = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?', 
    	  @quarter.client_id, '4', @quarter.year-1)
          end
              
    	  # Two Quarters Ago for @client
          if @quarter.quarter >= 3
    	  @twoqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?', 
    	  @quarter.client_id, @quarter.quarter-2, @quarter.year)
    	  elsif @quarter.quarter == 2
    	  @twoqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?', 
    	  @quarter.client_id, '4', @quarter.year-1)
          elsif @quarter.quarter == 1 
    	  @twoqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?', 
    	  @quarter.client_id, '3', @quarter.year-1)
          end

    	  # Three Quarters Ago for @client  
          if @quarter.quarter >= 4
    	  @threeqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?',
    				   @quarter.client_id, @quarter.quarter-3, @quarter.year)
    	  elsif @quarter.quarter == 3
    	  @threeqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?',
    				   @quarter.client_id, '4', @quarter.year-1)
          elsif @quarter.quarter == 2
    	  @threeqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?',
    				   @quarter.client_id, '3', @quarter.year-1)
          else @quarter.quarter <= 1
    	  @threeqtrago = Quarter.where('quarters.client_id=? and quarters.quarter=? and quarters.year=?',
    				   @quarter.client_id, '2', @quarter.year-1)
          end
          
           # Data History Variables for current 1@client:
           
            # << Production >>
            @oneago_prod = @lastqtr.sum(:production)
            @twoago_prod = @twoqtrago.sum(:production)
            @threeago_prod = @threeqtrago.sum(:production)

            # << Collections >>
            @oneago_coll = @lastqtr.sum(:collections)
            @twoago_coll = @twoqtrago.sum(:collections)
            @threeago_coll = @threeqtrago.sum(:collections)

            # << New Visits >>
            @oneago_new = @lastqtr.sum(:new_patients)
            @twoago_new = @twoqtrago.sum(:new_patients)
            @threeago_new = @threeqtrago.sum(:new_patients)

            # << Total Visits >>
            @oneago_tot = @lastqtr.sum(:total_visits)
            @twoago_tot = @twoqtrago.sum(:total_visits)
            @threeago_tot = @threeqtrago.sum(:total_visits)
            
            # << Net Worth >>
            @oneago_worth = @lastqtr.sum(:net_worth)
            @twoago_worth = @twoqtrago.sum(:net_worth)
            @threeago_worth = @threeqtrago.sum(:net_worth)
            
            #Historical Personal Savings Rates
            @oneago_rate = @lastqtr.sum(:personal_savings_rate)
            @twoago_rate = @twoqtrago.sum(:personal_savings_rate)
            @threeago_rate = @threeqtrago.sum(:personal_savings_rate)
             
            # *** Data History for Averages ***
          
            # << Average Production by specialty for all clients >>
            
              @thisqtravg_prod = Quarter.includes(:client).
             		where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
             		@quarter.client.specialty, @quarter.quarter, @quarter.year).average(:production).to_f
            
              @lastqtravg_prod = Quarter.includes(:client).
             		where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
             		@quarter.client.specialty, 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:production).to_f

              @twoqtragoavg_prod = Quarter.includes(:client).
              	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                @quarter.client.specialty, 	@twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:production).to_f
                
              @threeqtragoavg_prod = Quarter.includes(:client).
                where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                @quarter.client.specialty, 	@threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:production).to_f
                    
                # << Average Collections by specialty >>

               @thisqtravg_coll = Quarter.includes(:client).
               		where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
               		@quarter.client.specialty, @quarter.quarter, @quarter.year).average(:collections).to_f

               @lastqtravg_coll = Quarter.includes(:client).
               		where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
               		@quarter.client.specialty, 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:collections).to_f

               @twoqtragoavg_coll = Quarter.includes(:client).
                	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:collections).to_f

                @threeqtragoavg_coll = Quarter.includes(:client).
                  where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:collections).to_f

                   # << Average New Patients by specialty >>

                @thisqtravg_new = Quarter.includes(:client).
                 	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                 	@quarter.client.specialty, @quarter.quarter, @quarter.year).average(:new_patients).to_f

                @lastqtravg_new = Quarter.includes(:client).
                 	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                 	@quarter.client.specialty, 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:new_patients).to_f

                @twoqtragoavg_new = Quarter.includes(:client).
                  where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:new_patients).to_f

                @threeqtragoavg_new = Quarter.includes(:client).
                  where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:new_patients).to_f

                  # << Average Total Patients by specialty >>

                @thisqtravg_tot = Quarter.includes(:client).
                 	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                 	@quarter.client.specialty, @quarter.quarter, @quarter.year).average(:total_visits).to_f

                @lastqtravg_tot = Quarter.includes(:client).
                 	where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                 	@quarter.client.specialty, 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:total_visits).to_f

                @twoqtragoavg_tot = Quarter.includes(:client).
                  where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:total_visits).to_f

                @threeqtragoavg_tot = Quarter.includes(:client).
                  where('clients.specialty=? and quarters.quarter=? and quarters.year=?',
                  @quarter.client.specialty, 	@threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:total_visits).to_f

                  # << Average Net Worth across all clients - Not specific to specialty >>

                @thisqtravg_worth = Quarter.includes(:client).
               	  where('quarters.quarter=? and quarters.year=?',
                 	@quarter.quarter, @quarter.year).average(:net_worth).to_f

                @lastqtravg_worth = Quarter.includes(:client).
                 	where('quarters.quarter=? and quarters.year=?',
                 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:net_worth).to_f

                @twoqtragoavg_worth = Quarter.includes(:client).
                  where('quarters.quarter=? and quarters.year=?',
                  @twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:net_worth).to_f

                @threeqtragoavg_worth = Quarter.includes(:client).
                  where('quarters.quarter=? and quarters.year=?',
                  @threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:net_worth).to_f
                  
                  # << Average Net worth by age groups - Not specific to specialty >>
                 
                 @networthavg_30to40 = Quarter.includes(:client).
               	  where('clients.client_age>=? and clients.client_age<=? and quarters.quarter=? and quarters.year=?',
                  '35', '40', @quarter.quarter, @quarter.year).average(:net_worth).to_f
                    
                  # << Average Savings Rate - Not specific to specialty >>

                @thisqtravg_rate = Quarter.includes(:client).
              	  where('quarters.quarter=? and quarters.year=?',
                 	@quarter.quarter, @quarter.year).average(:personal_savings_rate).to_f

                @lastqtravg_rate = Quarter.includes(:client).
                 	where('quarters.quarter=? and quarters.year=?',
                 	@lastqtr.sum(:quarter), @lastqtr.sum(:year)).average(:personal_savings_rate).to_f

                @twoqtragoavg_rate = Quarter.includes(:client).
                  where('quarters.quarter=? and quarters.year=?',
                  @twoqtrago.sum(:quarter), @twoqtrago.sum(:year)).average(:personal_savings_rate).to_f

                @threeqtragoavg_rate = Quarter.includes(:client).
                  where('quarters.quarter=? and quarters.year=?',
                  @threeqtrago.sum(:quarter), @threeqtrago.sum(:year)).average(:personal_savings_rate).to_f


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quarter }
      format.pdf do
              render :pdf => "report",
                     :template => "/quarters/report.pdf.erb",
      end
    end
  end

  # GET /quarters/new
  # GET /quarters/new.json
  def new
    @quarter = Quarter.new(:client_id => params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quarter }
    end
  end

  # GET /quarters/1/edit
  def edit
    @quarter = Quarter.find(params[:id])
  end

  # POST /quarters
  # POST /quarters.json
  def create
    @quarter = Quarter.new(params[:quarter])

    respond_to do |format|
      if @quarter.save
        format.html { redirect_to @quarter, notice: 'Quarter was successfully created.' }
        format.json { render json: @quarter, status: :created, location: @quarter }
      else
        format.html { render action: "new" }
        format.json { render json: @quarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quarters/1
  # PUT /quarters/1.json
  def update
    @quarter = Quarter.find(params[:id])

    respond_to do |format|
      if @quarter.update_attributes(params[:quarter])
        format.html { redirect_to @quarter, notice: 'Quarter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @quarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quarters/1
  # DELETE /quarters/1.json
  def destroy
    @quarter = Quarter.find(params[:id])
    @quarter.destroy

    respond_to do |format|
      format.html { redirect_to quarters_url }
      format.json { head :ok }
    end
  end
  
  def showpdf 
      respond_to do |format|
        format.pdf do
          render :pdf => "file_name"
      end
    end
  end
  
end



