class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :is_admin_or_powner_or_rowner, :only =>[:destroy, :reactivate]
  before_filter :is_active_project, :only =>[:new, :edit]

  def make_risk_crumb
  add_breadcrumb @project.name, show_project_path(params[:pid])
    add_breadcrumb "Risks", risk_index_path(params[:pid])
  end

  def index
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    make_risk_crumb
    sort = params[:sort] || session[:sort]
    case sort
      when "title"
      @risks = @project.risks.sort_by { |risk| risk.title }
      when "status"
      @risks = @project.risks.sort_by { |risk| risk.status }
      when "owner"
      @risks = @project.risks.sort_by { |risk| User.find_by_id(risk.owner_id).username }
      when "early_impact"
      @risks = @project.risks.sort_by { |risk| risk.early_impact }
      when "last_impact"
      @risks = @project.risks.sort_by { |risk| risk.last_impact }
      else
        @risks = @project.risks
    end
    # @risks = @project.risks
    report = params[:report]
    case report
        when "current"
  @risks = @project.risks
  puts @risks
  when "near"
  @risks = @project.risks
  when "mid"
  @risks = @project.risks
  when "far"
  @risks = @project.risks
  when "past"
  @risks = @project.risks
    end
  end


  def new
    @users = User.active_users
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    make_risk_crumb
  add_breadcrumb "Create New Risk", new_risk_path
    @risk = nil
    if request.post?
      @risk = Risk.create_risk(session[:uid], params[:pid], params[:risk])
      if @risk.errors.empty?
        flash[:notice] = "Risk '#{@risk.title}' created."
        redirect_to risk_index_path(params[:pid])
      end
    end
  end

  def show
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    @risk = Risk.find_by_id(params[:rid])
    if @risk.nil?
      flash[:notice] = "That risk does not exist."
      redirect_to user_index_path
    end
  make_risk_crumb
  add_breadcrumb @risk.title, show_risk_path(@project.id, @risk.id)
    if not @risk.creator_id.nil?
      @risk_creator_username = @risk.find_username(@risk.creator_id)
      end
    if not @risk.owner_id.nil?
      @risk_owner_username = @risk.find_username(@risk.owner_id)
      end
    if not @risk.probability.nil?
      @risk_probability = int_to_value(@risk.probability)
    end
    if not @risk.cost.nil?
      @risk_cost = int_to_value(@risk.cost)
    end
    if not @risk.schedule.nil?
      @risk_schedule = int_to_value(@risk.schedule)
    end
    if not @risk.technical.nil?
      @risk_technical = int_to_value(@risk.technical)
    end
    @risk_rating = int_to_value(@risk.risk_rating)
  end

  def int_to_value(int)
    if int == 0
      return "N/A"
    elsif int == 1
      return "Low"
    elsif int == 2
      return "Med"
    elsif int == 3
      return "High"
    end
  end

  def edit
    @users = User.active_users
    @user = get_current_user
    @project = Project.find_by_id(params[:pid])

    #@risk = Risk.find_by_id(params[:rid])
    if @risk.nil?
      @risk = Risk.find_by_id(params[:rid])
      if @risk.nil?
        flash[:notice] = "That risk does not exist."
        redirect_to risk_index_path(params[:pid])
      end
    end
  make_risk_crumb
  add_breadcrumb @risk.title, show_risk_path(params[:pid], params[:rid])
  add_breadcrumb "Edit Risk", edit_risk_path(@risk.id)

    if !@risk.owner_id.nil?
      @risk_owner_username = @risk.find_username(@risk.owner_id)
    end
    if request.post?
      @risk = Risk.update_risk(params[:risk], Risk.find_by_id(params[:rid]), @user)
      if @risk.errors.empty?
        flash[:notice] = "Risk '#{@risk.title}' was successfully updated."
        redirect_to "/project/#{params[:pid]}/risk/#{params[:rid]}"
      end
    end
  end

  def destroy
    @risk = Risk.find(params[:rid])
    if @risk != nil
      get_current_user.deactivate_risk(params[:rid])
    end
    redirect_to risk_index_path(params[:pid]), :notice => "Risk '#{@risk.title}' deactivated."
  end

  def reactivate
    @risk = Risk.find(params[:rid])
    if @risk != nil
      get_current_user.reactivate_risk(params[:rid])
    end
    redirect_to risk_index_path(params[:pid]), :notice => "Risk '#{@risk.title}' reactivated."
  end

  def current_risks
    @risks = @project.risks
    date = Date.today
    curr_risks = []
    for risk in @risks
      if (risk.early_impact < date) and (risk.late_impact > date)
        curr_risks << risk
      end
    end
    curr_risks
  end

  def near_term_risks
    @risks = @project.risks
    date = Date.today
    near_risks = []
    for risk in @risks
      if (date-risk.early_impact).numerator <= 30
        near_risks << risk
      end
    end
    near_risks
  end

  def mid_term_risks
    @risks = @project.risks
    date = Date.today
    mid_risks = []
    for risk in @risks
      diff = date-risk.early_impact
      if (diff.numerator >= 30) and (diff.numerator <= 120)
        mid_risks << risk
      end
    end
    mid_risks
  end

  def far_term_risks
    @risks = @project.risks
    date = Date.today
    far_risks = []
    for risk in @risks
      diff = date-risk.early_impact
      if (diff.numerator <= 120)
        far_risks << risk
      end
    end
    far_risks
  end

  def past_risks
    @risks = @project.risks
    date = Date.today
    past_risks = []
    for risk in @risks
      diff = date-risk.late_impact
      if risk.status == "active" and (diff.numerator > 0)
        past_risks << risk
      end
    end
    past_risks
  end

end
