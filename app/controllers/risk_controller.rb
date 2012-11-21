class RiskController < ApplicationController
  before_filter :login_required
  before_filter :project_id_matches_user
  before_filter :is_admin_or_member, :only => [:new, :edit]
  before_filter :is_admin, :only =>[:destroy]

  add_breadcrumb "Home", :user_index_path
  def index

    @user = get_current_user
    @project = Project.find_by_id(params[:pid])
    add_breadcrumb @project.name, edit_project_path(params[:pid])
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
  end

  def new
    @user = get_current_user
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
    @risk = Risk.find_by_id(params[:rid])
    if @risk.nil?
      flash[:notice] = "That risk does not exist."
      redirect_to user_index_path
    end
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
  end

  def int_to_value(int)
    if int == 1
      return "Low"
    elsif int == 2
      return "Med"
    elsif int == 3
      return "High"
    end
  end

  def edit
    @user = get_current_user
    if params[:risk] ==nil
      @risk = Risk.find_by_id(params[:rid])
    else
      @risk = params[:risk]
    end
    if @risk.nil?
      flash[:notice] = "That risk does not exist."
      redirect_to risk_index_path(params[:pid])
    end
    if not @risk.owner_id.nil?
      @risk_owner_username = @risk.find_username(@risk.owner_id)
    end
  end

  def update
    @user = get_current_user
    @risk = Risk.update_risk(params[:risk], Risk.find_by_id(params[:rid]))
    if @risk.errors.empty?
      flash[:notice] = "Risk '#{@risk.title}' was successfully updated."
      redirect_to show_risk_path(params[:pid], params[:rid])
#      puts @risk.versions
    else
      redirect_to edit_risk_path(params[:pid], params[:rid]), :risk =>@risk
    end
  end

  def destroy
    @risk = Risk.find(params[:rid])
    if @risk != nil
      get_current_user.deactivate_risk(params[:rid])
    end
    redirect_to risk_index_path(params[:pid]), :notice => "Risk '#{@risk.title}' deactivated."
  end

end
