# coding: utf-8

class StatementsController < ApplicationController
  layout 'documents'
  helper_method :sort_column, :sort_direction
  #TODO переписать устаревшие нотации ActiveRecord

  def index
    @controller = params[:controller]
    current_user_id = current_user.id
    organization = current_user.organization_id
    
    #default scope
    if params[:status_sort]
      direction = params[:direction]
      sort_type = "not_accepted #{direction}", "accepted #{direction}", "opened #{direction}", "sent #{direction}", "approved #{direction}", "prepared #{direction}"
    else
      sort_type = sort_column + " " + sort_direction
    end
    
    @statements = Statement.order(sort_type).where{(sent == true) & (organization_id == organization) | 
                                (sender_organization_id == organization) & (user_id == current_user_id) | 
                                (prepared == true) & (sender_organization_id == organization) 
                                }
  end
  
  def drafts    
    @statements = Statement.drafts.where(:user_id => current_user.id)
    render :index
  end
  
  def new
    @statement = Statement.new
    organization = current_user.organization_id
    @writs = Document.writs.includes(:task_list).includes(:statements).where{(sent == true) & (organization_id == organization)}
                      .where("executed = #{false} AND task_lists.completed = #{true} AND with_comments = #{false} AND statements.id IS NULL OR with_comments = #{true} AND statements.with_completed_task_list")
                     # .where{(sent == true) & (organization_id == organization) & (executed == false)}
    # @writs = Document.writs.where{(sent == true) & (organization_id == organization) & (executed == false)}
    @acceptors = User.find( :all, :include => :permissions, :conditions => "permissions.id = 2 AND organization_id != #{current_user.organization_id}")
    @approvers = User.find( :all, :include => :permissions, :conditions => "permissions.id = 1 AND organization_id = #{current_user.organization_id}")
  end
  
  def create
    organization = current_user.organization_id
    @writs = Document.writs.where{(sent == true) & (organization_id == organization) & (executed == false)}
    @acceptors = User.find( :all, :include => :permissions, :conditions => "permissions.id = 2 AND organization_id != #{current_user.organization_id}")
    @approvers = User.find( :all, :include => :permissions, :conditions => "permissions.id = 1 AND organization_id = #{current_user.organization_id}")
    @statement = Statement.new(params[:statement])
    
    document_id = params[:statement][:document_ids].second
    
    @statement.approver_id = params[:statement][:internal_approver_id].second
    
    @statement.user_id = current_user.id
    @statement.sender_organization_id = current_user.organization_id
    
    if document_id
      @statement.document_id = document_id
      document = Document.find(document_id)
      organization_id = document.sender_organization_id
      @statement.organization_id = organization_id
    end
    
    
    if params[:prepare]
      @statement.prepared = true
      @statement.prepared_date = Time.now
      @statement.draft = false
    end

    respond_to do |format|
      if @statement.save
        format.html { redirect_to statement_path(@statement), notice: t('document_successfully_created') }
        format.json { render json: @statement, status: :created, location: @statement }
      else
        format.html { render action: "new" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @statement = Statement.find(params[:id])
    @acceptors = User.find( :all, :include => :permissions, :conditions => "permissions.id = 2 AND organization_id != #{current_user.organization_id}")
    @approvers = User.find( :all, :include => :permissions, :conditions => "permissions.id = 1 AND organization_id = #{current_user.organization_id}")
    
    
    organization = current_user.organization_id
    @writs = Document.writs.where{(sent == true) & (organization_id == organization) & (executed == false)}
    
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
    @statement.approver_id = params[:statement][:internal_approver_id].second
    
    respond_to do |format|
      if @statement.update_attributes(params[:statement])
        format.html { redirect_to statement_path(@statement), notice: t('statement_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @statement = Statement.find(params[:id])
    @task_list = @statement.task_list
    Document.exists?(@statement.document_id) ? @writ = Document.find(@statement.document_id) : @writ = nil 
  
    
    if @statement.organization_id == current_user.organization_id && current_user.has_permission?(2)
      @statement.opened = true
      @statement.opened_date = Time.now
      @statement.save
    end
    
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = StatementPdf.new(@statement, view_context)
        send_data pdf.render, filename: "document_#{@statement.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
    
  end
  
  def prepare
    @statement = Statement.find(params[:id])
    
    if current_user.id == @statement.user_id    
      @statement.prepared = true
      @statement.prepared_date = Time.now
      @statement.draft = false
      @statement.save
      redirect_to statements_path, notice: t('statement_prepared')
    else
      redirect_to :back, notice: t('access_denied')
    end    
  end
  
  def approve
    @statement = Statement.find(params[:id])
    
    if current_user.id == @statement.approver_id && @statement.approved == false  
      @statement.draft = false
      @statement.approved = true
      @statement.approved_date = Time.now
      @statement.date = Time.now
      @statement.sn = "D" + @statement.id.to_s
      @statement.save
      redirect_to statements_path, notice: t('statement_approved')
    else
      redirect_to :back, alert: t('permission_denied')
    end
  end
  
  def send_statement
    @statement = Statement.find(params[:id])
    document = Document.find(@statement.document_id)
    document.for_confirmation = true
    document.save!
    @statement.sent = true
    @statement.sent_date = Time.now
    @statement.save!
    redirect_to statements_path, :notice => t('statement_sent')
  end
  
  def accept
    @statement = Statement.find(params[:id])
    
    if @statement.user_ids.include?(current_user.id) && current_user.has_permission?(2)
      statement_approver = @statement.statement_approvers.find_by_user_id(current_user.id)
      statement_approver.accepted = true
      statement_approver.save
    end
    
    if @statement.statement_approvers.pluck(:accepted).exclude?(nil)    
      document = Document.find(@statement.document)
      document.executed = true
      document.executed_date = Time.now
      document.save  
      task = document.task
      task.completed = true
      task.save
      @statement.accepted = true
      @statement.accepted_date = Time.now
      @statement.save
    end

    respond_to do |format|
      format.html { redirect_to statements_path, notice: t('statement_accepted') }
      format.json { render json: @statement }
    end
  end
  
  def task_list
    @statement = Statement.find(params[:id])
    @writ = Document.find(@statement.document_id)
    @task_list = @statement.build_task_list
    @task_list.tasks.build
  end
  
  def refuse
    statement = Statement.find(params[:id])
    if statement.user_ids.include?(current_user.id)
      statement.accepted = false
      statement.not_accepted = true
      statement.refuse_date = Time.now
      statement.save
      initial_document = Document.find(statement.document)
      initial_document.with_comments = true
      initial_document.executed = false
      initial_document.save
      @document = Document.new
      @document.document_type = 'writ'
      @document.title = "В ответ на акт №" + statement.id.to_s
      @document.organization_id = initial_document.organization_id
      @document.approver_id = initial_document.approver_id
      @document.executor_id = initial_document.executor_id
      @document.text = "Исполнить задачи согласно листу замечаний"

      @approvers = User.approvers.where("organization_id = ?", current_user.organization_id)
      @executors = User.where(:organization_id => current_user.organization_id)
      @recipients = User.where('organization_id != ?', current_user.organization_id)
      @documents = Document.all
      @task_list = @document.build_task_list

      render "documents/new"
    else
      redirect_to documents_path, :alert => t('permission_denied')
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
