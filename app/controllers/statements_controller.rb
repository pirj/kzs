class StatementsController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    current_user_id = current_user.id
    organization = current_user.organization_id
    
    @statements = Statement.where{(sent == true) & (organization_id == organization) | 
                                (sender_organization_id == organization) & (user_id == current_user_id) | 
                                (prepared == true) & (sender_organization_id == organization) 
                                }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end
  
  def drafts    
    @statements = Statement.drafts.where(:user_id => current_user.id)
    render :index
  end
  
  def new
    @statement = Statement.new
    organization = current_user.organization_id
    @writs = Document.writs.where{(sent == true) & (organization_id == organization)}
    @approvers = User.find( :all, :include => :permissions, :conditions => "permissions.id = 2 AND organization_id = #{current_user.organization_id}")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement }
    end
  end
  
  def create
    @statement = Statement.new(params[:statement])
    
    @statement.user_id = current_user.id
    @statement.sender_organization_id = current_user.organization_id
    @statement.document_id = params[:statement][:document_ids].second
    @statement.organization_id = @statement.document.sender_organization_id
    
    
    if params[:prepare]
      @statement.prepared = true
      @statement.draft = false
    end

    respond_to do |format|
      if @statement.save && 
        format.html { redirect_to documents_path, notice: t('document_successfully_created') }
        format.json { render json: @statement, status: :created, location: @statement }
      else
        format.html { render action: "new" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @statement = Statement.find(params[:id])
    organization = current_user.organization_id
    @writs = Document.writs.where{(sent == true) & (organization_id == organization)}
    @approvers = User.find( :all, :include => :permissions, :conditions => "permissions.id = 2 AND organization_id = #{current_user.organization_id}")
    
    respond_to do |format|
      if @statement.user_id == current_user.id && @statement.sent == false
        format.html
      else
        format.html { redirect_to :back, notice: t('access_denied') }
      end
    end

  end
  
  def update
    @statement = Statement.find(params[:id])
    
    respond_to do |format|
      if @statement.update_attributes(params[:statement])
        format.html { redirect_to statements_path, notice: t('statement_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @statement = Statement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end
  
  def prepare
    @statement = Statement.find(params[:id])
    
    if current_user.id == @statement.user_id    
      @statement.prepared = true
      @statement.draft = false
      @statement.save
      redirect_to statements_path, notice: t('statement_prepared')
    else
      redirect_to :back, notice: t('access_denied')
    end
      
  end
  
  def send_statement
    @statement = Statement.find(params[:id])
    @statement.sent = true
    @statement.save
    redirect_to statements_path, :notice => 'statement_sent'
  end
  
  def accept
    @statement = Statement.find(params[:id])
    @statement.accepted = true
    @statement.not_accepted = false
    @statement.save
    
    document = Document.find(@statement.document)
    document.executed = true
    document.save    

    respond_to do |format|
      format.html { redirect_to statements_path, notice: t('statement_accepted') }
      format.json { render json: @statement }
    end
  end
  
  def refuse
    @statement = Statement.find(params[:id])
    @statement.accepted = false
    @statement.not_accepted = true
    @statement.save
    
    document = Document.find(@statement.document)
    document.with_comments = true
    document.executed = false
    document.save
    

    respond_to do |format|
      format.html { redirect_to statements_path, notice: t('statement_refused') }
      format.json { render json: @statement }
    end
  end
  
  private
  
  def sort_column
    Statement.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
